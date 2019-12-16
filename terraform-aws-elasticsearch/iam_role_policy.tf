
# Role that pods can assume for access to elasticsearch and kibana
resource "aws_iam_role" "elasticsearch_user" {
  name               = "module.user_label.id"
  assume_role_policy = join("", data.aws_iam_policy_document.assume_role.*.json)
  description        = "IAM Role to assume to access the Elasticsearch module.label.id cluster"

  tags = {
    tag-key = "tag-value"
  }
}

data "aws_iam_policy_document" "assume_role" {

  statement {
    actions = [
      "sts:AssumeRole"
    ]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    effect = "Allow"
  }
}


data "aws_iam_policy_document" "default" {

  statement {
    actions = ["es:*", ]
    resources = [
      join("", aws_elasticsearch_domain.default.*.arn),
      "${join("", aws_elasticsearch_domain.default.*.arn)}/*"
    ]

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }
  }
}

resource "aws_elasticsearch_domain_policy" "default" {
  domain_name     = "easyaws"
  access_policies = join("", data.aws_iam_policy_document.default.*.json)
}

provider "aws" {
  region     = var.region
  version    = "~> 2.0"
}

resource "aws_iam_role" "ec2_role" {
  name = "ec2_terraform_role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF

  tags = {
      tag-key = "tag-value"
  }
}

resource "aws_iam_role_policy" "ec2_policy" {
  name = "ec2_terraform_policy"
  role = aws_iam_role.ec2_role.id

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:*"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_iam_instance_profile" "ec2_profile" {
  name = "ec2_terraform_profile"
  role = aws_iam_role.ec2_role.name
}

resource "aws_instance" "ebs_instance_example" {
  ami           = lookup(var.ami_id, var.region)
  instance_type = var.instance_type
  iam_instance_profile = aws_iam_instance_profile.ec2_profile.name
  # key name
  key_name = var.key_name
  # User data passing through template rendering

  tags = {
    Name = "Roles with Ec2"
  }
}

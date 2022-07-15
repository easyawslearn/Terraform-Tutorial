provider "aws" {
  region = "eu-west-1"
}

module "sns_cloudwatch" {
  source = "github.com/easyawslearn/Terraform-Tutorial/terraform-aws-sns"
  cloudwatch_event_rule_name        = "capture-aws-sign-in"
  description = "Capture each AWS Console Sign In"
  sns_name = "mysns"
  sns_display_name = "demosns"
  lambda_function_name = "S3cloudHub_Test_Lambda_Function"
  lambda_function_runtime = "python3.8"
}

#IAM Role Module

locals {
  enabled = true
}

data "aws_iam_policy_document" "resource_full_access" {
  count = local.enabled ? 1 : 0

  statement {
    sid       = "FullAccess"
    effect    = "Allow"
    # resources = ["arn:aws:s3:::iammodule"]
    resources = ["*"]

    actions = [
      "s3:*",
      "s3-object-lambda:*",
      "sns:*",
      "autoscaling:Describe*",
      "cloudwatch:*",
      "logs:*",
      "iam:GetPolicy",
      "iam:GetPolicyVersion",
      "iam:GetRole"
    ]
  }
}

data "aws_iam_policy_document" "base" {
  count = local.enabled ? 1 : 0

  statement {
    sid    = "BaseAccess"
    effect = "Allow"

    actions = [
      "s3:ListBucket",
      "s3:ListBucketVersions"
    ]

    resources = [
      "arn:aws:s3:::iammodule"
    ]
  }
}

module "role" {
  source = "../"

#   principals    = var.principals
#   iam_role_name = "mydemorole"

  policy_documents = [
    join("", data.aws_iam_policy_document.resource_full_access.*.json),
    join("", data.aws_iam_policy_document.base.*.json),
  ]

  policy_document_count    = 2
  policy_description       = "Test IAM policy"
  role_description         = "Test IAM role"
  instance_profile_enabled = true

  #   context = module.this.context
}

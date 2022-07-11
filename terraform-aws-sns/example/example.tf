provider "aws" {
  region = "eu-west-1"
}

module "sns_cloudwatch" {
  source = "../"
  name        = "capture-aws-sign-in"
  description = "Capture each AWS Console Sign In"
  target_id = "SendToSNS"
}


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

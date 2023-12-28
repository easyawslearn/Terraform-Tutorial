config {
  module = true
  deep_check = true
  force = false
  ignore_module = {
    "github.com/terraform-aws-modules/security-group/aws" = true
  }
  varfile = ["example1.tfvars", "example2.tfvars"]
  ignore_rule = {
    "aws_instance_invalid_type" = true
  }
  enable_rule = {
    "terraform_naming_convention" = true
  }
  disabled_by_default = false
}

plugin "aws" {
  enabled = true
  version = "0.7.0"
  source = "github.com/terraform-linters/tflint-ruleset-aws"
}

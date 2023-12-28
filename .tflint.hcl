config {
  module = true
  deep_check = true
  force = false
}

rule "aws_instance_invalid_type" {
    enabled = false
}

plugin "aws" {
  enabled = true
  version = "0.7.0"
  source = "github.com/terraform-linters/tflint-ruleset-aws"
}

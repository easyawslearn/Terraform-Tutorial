terraform {
  required_version = ">= 0.11.0"
  backend "s3" {
    bucket = "backup-state-terraform"
    key    = "terraform/test"
    region = "us-east-1"
    dynamodb_table = "backend-test"
  }
}

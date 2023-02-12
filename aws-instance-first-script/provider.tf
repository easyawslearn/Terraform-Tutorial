terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.53"
    }
  }

  required_version = ">= 1.3.8"
}

provider "aws" {
  region     = "us-west-1"
}

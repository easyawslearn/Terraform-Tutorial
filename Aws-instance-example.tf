provider "aws"{
 region     = "us-east-1"
 access_key = "AKIASGHX7SHCBQNPCDUB"
 secret_key = "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"
 version = "~> 2.0"

}

resource "aws_instance" "web" {
  ami           = "ami-0ad82a384c06c911e"
  instance_type = "t2.micro"

  tags = {
    Name = "HelloWorld"
  }
}

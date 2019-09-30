provider "aws" {
  region     = "${var.region}"
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  version    = "~> 2.0"
}

resource "aws_instance" "my_web_server" {
  ami           = "${lookup(var.ami_id, var.region)}"
  instance_type = "t2.micro"
}

provider "aws" {
  region = var.region
}

resource "aws_instance" "ebs_instance_example" {
  ami           = lookup(var.ami_id, var.region)
  instance_type = var.instance_type
  subnet_id     = aws_subnet.public_1.id

  # Security group assign to instance
  vpc_security_group_ids = [aws_security_group.allow_ssh.id]

  # key name
  key_name = var.key_name

  tags = {
    Name = "Ec2-with-VPC"
  }
}

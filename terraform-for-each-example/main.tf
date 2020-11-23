variable "vpc_id" {
  description = "ID for the AWS VPC where a security group is to be created."
}

variable "subnet_numbers" {
  description = "List of 8-bit numbers of subnets of base_cidr_block that should be granted access."
  default = [1, 2, 3, 4, 5, 6]
}

data "aws_vpc" "example" {
  id = var.vpc_id
}


resource "aws_security_group" "example" {
  name        = "for_each_example"
  description = "Allows access from friendly subnets"
  vpc_id      = var.vpc_id

  ingress {
    from_port = 0
    to_port   = 0
    protocol  = -1

    cidr_blocks = [
      for num in var.subnet_numbers:
      cidrsubnet(data.aws_vpc.example.cidr_block, 8, num)
    ]
  }
}
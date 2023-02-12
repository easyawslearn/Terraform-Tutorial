resource "aws_instance" "my_vm" {
  instance_type = "t2.micro"
  ami           = "ami-0aa7d40eeae50c9a9" //Ubuntu AMI

  tags = {
    Name = "ubuntu_server"
  }
}

resource "aws_vpc" "my_first_vpc" {
  cidr_block = "10.0.0.0/24"

  tags = {
    name = "production_vpc"
  }
}

resource "aws_subnet" "subnet-1" {
  vpc_id     = aws_vpc.my_first_vpc.id
  cidr_block = "10.0.0.0/24"

  tags = {
    name = "prod-subnet"
  }
}

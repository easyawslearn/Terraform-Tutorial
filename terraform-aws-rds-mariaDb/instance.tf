provider "aws" {
  region     = "${var.region}"
  version    = "~> 2.0"
}


resource "aws_instance" "rds_example" {
  ami           = lookup(var.ami_id, var.region)
  instance_type = var.instance_type
  subnet_id     = aws_subnet.public_1.id

  # Security group assign to instance
  vpc_security_group_ids = [aws_security_group.allow_ssh_http.id]
  availability_zone="us-east-1a"
  # key name
  key_name = var.key_name

  user_data = <<EOF
    #! /bin/bash
                sudo yum update -y
    sudo yum install -y httpd.x86_64
    sudo service httpd start
    sudo service httpd enable
    echo "<h1>Deployed via Terraform</h1>" | sudo tee /var/www/html/index.html
  EOF

  tags = {
    Name = "RDS_MariaDB_Example"
  }
}


output "public_ip" {
  value = aws_instance.rds_example.public_ip
}

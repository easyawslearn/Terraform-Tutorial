resource "aws_instance" "elb_instance_example1" {
  ami           = lookup(var.ami_id, var.region)
  instance_type = var.instance_type
  subnet_id     = aws_subnet.public_1.id

  # Security group assign to instance
  vpc_security_group_ids = [aws_security_group.elb_sg.id]

  # key name
  key_name = var.key_name

  user_data = <<EOF
		#! /bin/bash
                sudo yum update -y
		sudo yum install -y httpd.x86_64
		sudo service httpd start
		sudo service httpd enable
		echo "<h1>Deployed ELB Instance Example 1</h1>" | sudo tee /var/www/html/index.html
	EOF

  tags = {
    Name = "EC2-Instance-1"
  }
}

resource "aws_instance" "elb_instance_example2" {
  ami           = lookup(var.ami_id, var.region)
  instance_type = var.instance_type
  subnet_id     = aws_subnet.public_1.id

  # Security group assign to instance
  vpc_security_group_ids = [aws_security_group.elb_sg.id]

  # key name
  key_name = var.key_name

  user_data = <<EOF
		#! /bin/bash
                sudo yum update -y
		sudo yum install -y httpd.x86_64
		sudo service httpd start
		sudo service httpd enable
		echo "<h1>Deployed ELB Instance Example 2</h1>" | sudo tee /var/www/html/index.html
	EOF

  tags = {
    Name = "EC2-Instance-1"
  }
}

resource "aws_db_parameter_group" "default" {
  name   = "mariadb"
  family = "mariadb10.2"

  parameter {
    name  = "max_allowed_packet"
    value = "16777216"
  }
}

resource "aws_db_subnet_group" "default" {
  name       = "main"
  subnet_ids = [aws_subnet.private_1.id, aws_subnet.private_2.id]

  tags = {
    Name = "My DB subnet group"
  }
}

resource "aws_db_instance" "default" {
  allocated_storage    = 20
  storage_type         = "gp2"
  engine               = "mariadb"
  engine_version       = "10.2.21"
  instance_class       = "db.t2.micro"
  name                 = "mydb"
  username             = "root"
  password             = "foobarbaz"
  parameter_group_name = "mariadb"
  db_subnet_group_name=aws_db_subnet_group.default.name
  vpc_security_group_ids=[aws_security_group.db.id]
  availability_zone=aws_subnet.private_1.availability_zone
}

output "end_point" {
  value = aws_db_instance.default.endpoint
}

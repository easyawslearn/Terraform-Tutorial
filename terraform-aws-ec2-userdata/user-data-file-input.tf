
resource "aws_instance" "user_data_example_input_file" {
  ami           = lookup(var.ami_id, var.region)
  instance_type = var.instance_type
#  subnet_id     = aws_subnet.public_1.id

  # Security group assign to instance
  vpc_security_group_ids = [aws_security_group.allow_ssh.id]

  # key name
  key_name = var.key_name
  user_data = "${file("apache_config.sh")}"

  tags = {
    Name = "Ec2-User-data-with-file"
  }
}

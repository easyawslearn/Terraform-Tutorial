
resource "aws_instance" "iam_role_instance_example" {
  ami           = lookup(var.ami_id, var.region)
  instance_type = var.instance_type
  iam_instance_profile = aws_iam_instance_profile.ec2_profile.name
  # key name
  key_name = var.key_name
  # User data passing through template rendering

  tags = {
    Name = "Roles with Ec2"
  }
}

output "public_ip" {
  value = aws_instance.iam_role_instance_example.public_ip
}

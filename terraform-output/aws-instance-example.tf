resource "aws_instance" "web-server" {
   ami           = "${lookup(var.ami_id, var.region)}"
   instance_type = "t2.micro"
 }

output "public_ip"{
  value="${aws_instance.web-server.public_ip}"
}

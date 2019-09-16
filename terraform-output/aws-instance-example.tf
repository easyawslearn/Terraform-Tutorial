resource "aws_instance" "web-server" {
  ami           = "${lookup(var.ami_id, var.region)}"
  instance_type = "t2.micro"


  provisioner "local-exec" {
    command = "echo ${aws_instance.web-server.private_ip} >> ip_list.txt"
  }

  provisioner "local-exec" {
    command = "echo ${aws_instance.web-server.arn} >> arn.txt"
  }
}


resource "aws_instance" "web-server" {
  ami           = "${lookup(var.ami_id, var.region)}"
  instance_type = "t2.micro"
  key_name      = "terraform"


  provisioner "file" {
    source      = "index.html"
    destination = "/tmp/index.html"
  }
  provisioner "remote-exec" {
      inline = [
        "sudo yum install -y httpd;sudo cp /tmp/index.html /var/www/html/",
        "sudo service httpd restart",
        "sudo service httpd status"
      ]
    }
  connection {
    user        = "ec2-user"
    private_key = "${file("${var.private_key_path}")}"
      host = "${aws_instance.web-server.public_ip}"
  }
}

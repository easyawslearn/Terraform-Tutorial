output "public_ip" {
  value = "${aws_instance.web-server.public_ip}"
}

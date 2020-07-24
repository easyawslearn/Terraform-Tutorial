output "public_ip" {
  value = "${aws_instance.user_data_example.public_ip}"
}

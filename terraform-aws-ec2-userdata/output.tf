output "public_ip" {
  value = "${aws_instance.user_data_example.public_ip}"
}
output "user_data_example_input_file" {
  value = "${aws_instance.user_data_example_input_file.public_ip}"
}

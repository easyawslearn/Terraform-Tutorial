output "user_data_example_input_file" {
  value = "${aws_instance.user_data_example_input_file.public_ip}"
}

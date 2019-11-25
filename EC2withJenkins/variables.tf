variable "region" {
  type    = "string"
  default = "us-east-1"
}
variable "ami_id" {
  type = "map"
  default = {
    us-east-1    = "ami-00dc79254d0461090"
  }
}
variable "instance_type" {
  type    = "string"
  default = "t2.micro"
}
variable "key_name" {
  type    = "string"
  default = "ec2-demo"
}

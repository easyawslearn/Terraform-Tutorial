variable "region" {
  default = "us-east-2"
}

variable "ami_id" {
  type = "map"

  default = {
    us-east-1    = "ami-0b9064170e32bde34"
      }
}

variable "region" {
  default = "us-east-1"
}

variable "ami_id" {
  type = "map"

  default = {
    us-east-1    = "ami-0aa7d40eeae50c9a9"
  }
}

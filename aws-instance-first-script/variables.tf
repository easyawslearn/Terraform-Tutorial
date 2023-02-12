
variable "region" {
  default = "us-east-1"
}

variable "ami_id" {
  type = map(string)

  default = {
    us-east-1    = "ami-0557a15b87f6559cf"
    eu-west-2    = "ami-132b3c7efe6sdfdsfd"
    eu-central-1 = "ami-9787h5h6nsn"
  }
}

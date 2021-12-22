variable "region" {
  default = "us-east-1"
}

variable "ami_id" {
  type = map(string)

  default = {
    us-east-1    = "ami-0ed9277fb7eb570c9"
    eu-west-2    = "ami-03af6a70ccd8cb578"
    eu-central-1 = "ami-05d34d340fb1d89e5"
  }
}

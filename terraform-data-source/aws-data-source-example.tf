data "aws_vpc" "selected" {

  filter {
    name   = "tag:Name"
    values = ["Default"]
  }
}

resource "aws_subnet" "example" {
  vpc_id            = "${data.aws_vpc.selected.id}"
  cidr_block        = "172.31.0.0/20"
}

resource "aws_internet_gateway" "gw" {
  vpc_id = "${aws_vpc.vpc_demo.id}"

  tags = {
    Name = "internet-gateway-demo"
  }
}

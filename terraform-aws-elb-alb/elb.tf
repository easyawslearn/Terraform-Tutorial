provider "aws" {
  region = var.region
}

resource "aws_lb" "elb_example" {
  name               = "elb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.elb_sg.id]
  subnets            = [aws_subnet.public_1.id,aws_subnet.public_2.id]

  enable_deletion_protection = true
    tags = {
    Environment = "elb-example"
  }
}

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.elb_example.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.test.arn

    }
}

resource "aws_lb_target_group" "test" {
  name     = "tf-example-lb-tg"
  port     = 80
  protocol = "HTTP"
  target_type="instance"
  vpc_id   = aws_vpc.vpc_demo.id
}

resource "aws_lb_target_group_attachment" "test" {
  target_group_arn = aws_lb_target_group.test.arn
  target_id        = aws_instance.elb_instance_example1.id
  port             = 80
}
resource "aws_lb_target_group_attachment" "test1" {
  target_group_arn = aws_lb_target_group.test.arn
  target_id        = aws_instance.elb_instance_example2.id
  port             = 80
}


output "elb_example" {
  description = "The DNS name of the ELB"
  value       = aws_lb.elb_example.dns_name
}

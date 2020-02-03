resource "aws_route53_zone" "easy_aws" {
  name = "easyaws.in"

  tags = {
    Environment = "dev"
  }
}

resource "aws_route53_record" "www" {
  zone_id = aws_route53_zone.easy_aws.zone_id
  name    = "www.easyaws.in"
  type    = "A"

  alias {
     name                   = aws_lb.elb_example.dns_name
     zone_id                = aws_lb.elb_example.zone_id
     evaluate_target_health = true
   }

}

output "name_server"{
  value=aws_route53_zone.easy_aws.name_servers
}

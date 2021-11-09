data "aws_route53_zone" "serverspec_operations_net" {
  name = "serverspec-operations.net"
}

resource "aws_route53_record" "sample" {
  zone_id = data.aws_route53_zone.serverspec_operations_net.zone_id
  name    = data.aws_route53_zone.serverspec_operations_net.name
  type    = "A"

  alias {
    evaluate_target_health = true
    name                   = aws_lb.sample.dns_name
    zone_id                = aws_lb.sample.zone_id
  }
}

output "domain_name" {
  value = aws_route53_record.sample.name
}

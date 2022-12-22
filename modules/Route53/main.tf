resource "aws_route53_zone" "primary" {
  name = var.name
}
resource "aws_route53_record" "www-prod" {
  zone_id = aws_route53_zone.primary.zone_id
  name    = var.name
  type    = var.recored_type
  #ttl     = 5

  # weighted_routing_policy {
  #   weight = 10
  # }

  alias{
    name = var.alias_name
    zone_id = var.alias_zone_id
    evaluate_target_health = true
  }
}
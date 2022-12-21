resource "aws_route53_zone" "primary" {
  name = var.name
}
# resource "aws_route53_record" "www-prod" {
#   zone_id = aws_route53_zone.primary.zone_id
#   name    = "www"
#   type    = "CNAME"
#   ttl     = 5

#   weighted_routing_policy {
#     weight = 10
#   }

#   set_identifier = "prod"
#   records        = var.records
# }
output "name" {
  value = aws_cloudfront_distribution.my_web_site.domain_name
}

output "zone_id" {
  value = aws_cloudfront_distribution.my_web_site.hosted_zone_id
}
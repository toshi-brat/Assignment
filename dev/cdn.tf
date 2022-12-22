module "cdn" {
  source                 = "../modules/CloudFront"
  domian_name            = module.front-end-alb.alb-dns
  origin_id              = "lb-origin"
  log_bucket             = module.log_bucket.bucker_arn
  origin_http_port       = "80"
  origin_https_port      = "443"
  origin_protocol_policy = "match-viewer"
  origin_ssl_protocols   = ["TLSv1.2"]
}
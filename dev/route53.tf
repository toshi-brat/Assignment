module "R53" {
  source        = "../modules/Route53"
  name          = "example.com"
  recored_type  = "A"
  alias_name    = module.cdn.name
  alias_zone_id = module.cdn.zone_id

}

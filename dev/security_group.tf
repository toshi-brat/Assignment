module "front-end-sg" {
  source     = "../modules/security_group"
  vpc_id     = module.vpc1.vpc-id
sg_details = {
  "web-server" = {
    description = "httpd inbound"
    name        = "web-server"
    ingress_rules = [
        {
          cidr_blocks     = ["0.0.0.0/0"]
          from_port       = 80
          protocol        = "tcp"
          self            = null
          to_port         = 80
          security_groups = null
        },
        {
          cidr_blocks     = ["0.0.0.0/0"]
          from_port       = 443
          protocol        = "tcp"
          self            = null
          to_port         = 443
          security_groups = null
        }
    ]
  }
}
}
module "back-end-sg" {
  source     = "../modules/security_group"
  vpc_id     = module.vpc1.vpc-id
sg_details = {
  "web-server" = {
    description = "httpd inbound"
    name        = "web-server"
    ingress_rules = [
        {
          cidr_blocks     = ["0.0.0.0/0"]
          from_port       = 8080
          protocol        = "tcp"
          self            = null
          to_port         = 80
          security_groups = lookup(module.front-end-sg.output-sg-id,"web-server",null)
        }
    ]
  }
}
}
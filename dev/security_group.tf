module "lb-sg" {
  source = "../modules/security"
  vpc_id = module.uat_vpc.vpc-id
  sg_details = {
    "lb-sg" = {
      description = "httpd inbound"
      name        = "lb-sg"
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
module "front-end-sg" {
  source = "../modules/security"
  vpc_id = module.uat_vpc.vpc-id
  sg_details = {
    "web-server" = {
      description = "httpd inbound"
      name        = "web-server"
      ingress_rules = [
        {
          cidr_blocks     = null
          from_port       = 80
          protocol        = "tcp"
          self            = null
          to_port         = 80
          security_groups = [lookup(module.lb-sg.output-sg-id, "lb-sg", null)]
        }
      ]
    }
  }
}
module "internal-lb-sg" {
  source = "../modules/security"
  vpc_id = module.uat_vpc.vpc-id
  sg_details = {
    "internal-lb" = {
      description = "httpd inbound"
      name        = "web-server"
      ingress_rules = [
        {
          cidr_blocks     = null
          from_port       = 80
          protocol        = "tcp"
          self            = null
          to_port         = 80
          security_groups = [lookup(module.front-end-sg.output-sg-id, "web-server", null)]
        }
      ]
    }
  }
}

module "back-end-sg" {
  source = "../modules/security"
  vpc_id = module.uat_vpc.vpc-id
  sg_details = {
    "app-server" = {
      description = "http inbound"
      name        = "app-server"
      ingress_rules = [
        {
          cidr_blocks     = null
          from_port       = 8080
          protocol        = "tcp"
          self            = null
          to_port         = 8080
          security_groups = [lookup(module.internal-lb-sg.output-sg-id, "internal-lb", null)]
        }
      ]
    }
  }
}

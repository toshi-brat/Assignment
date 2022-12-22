module "front-end-alb" {
  source = "../modules/load_balancer"
  lb_sg  = lookup(module.lb-sg.output-sg-id, "lb-sg", null)
  vpc-id = module.uat_vpc.vpc-id
  snet = {
    snet1 = {
      snet-id = lookup(module.uat_vpc.pub-snet-id, "s1", null)
    },
    snet2 = {
      snet-id = lookup(module.uat_vpc.pub-snet-id, "s2", null)
    }
  }
  internal          = false
  tg-name           = "front-end-tg"
  health_check_port = "80"
}

module "back-end-alb" {
  source = "../modules/load_balancer"
  lb_sg  = lookup(module.internal-lb-sg.output-sg-id, "internal-lb", null)
  vpc-id = module.uat_vpc.vpc-id
  snet = {
    snet1 = {
      snet-id = lookup(module.uat_vpc.pri-snet-id, "ps1", null)
    },
    snet2 = {
      snet-id = lookup(module.uat_vpc.pri-snet-id, "ps2", null)
    }
  }
  internal          = true
  tg-name           = "back-end-tg"
  health_check_port = "8080"
}
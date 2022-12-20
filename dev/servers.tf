module "web-server" {
  source        = "../modules/servers"
  name          = "web-launch-conf"
  web-image-id  = "ami-07651f0c4c315a529"
  instance-type = "t2.micro"
  key_name      = "key-nv-pair"
  web-sg        = [lookup(module.front-end-sg.output-sg-id, "web-server", null)]
  asg-name      = "web-server-asg"
  min-size      = "1"
  desired-size  = "1"
  max-size      = "1"
  target-group  = module.front-end-alb.frontend-tg-arn
  subnet        = [lookup(module.uat_vpc.pri-snet-id, "ps1", null), lookup(module.uat_vpc.pri-snet-id, "ps2", null)]
  instance-profile = module.iam.instance_profile
}



module "app-server" {
  source        = "../modules/servers"
  name          = "app-launch-conf"
  web-image-id  = "ami-07651f0c4c315a529"
  instance-type = "t2.micro"
  key_name      = "key-nv-pair"
  web-sg        = [lookup(module.back-end-sg.output-sg-id, "app-server", null)]
  asg-name      = "app-server-asg"
  min-size      = "1"
  desired-size  = "1"
  max-size      = "1"
  target-group  = module.front-end-alb.backend-tg-arn
  subnet        = [lookup(module.uat_vpc.pri-snet-id, "ps1", null), lookup(module.uat_vpc.pri-snet-id, "ps2", null)]
  instance-profile = module.iam.instance_profile 
}




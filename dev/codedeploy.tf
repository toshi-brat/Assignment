module "Web_CodeDeploy" {
  source                = "../modules/CodeDeploy"
  platform              = "Server"
  name                  = "Web-Deploy"
  deployment_group_name = "web-deployment-group"
  service_role_arn      = module.iam.codedeploy
  alb-name              = module.front-end-alb.alb-name
  autoscaling_groups    = module.web-server.asg-name
}

module "App_CodeDeploy" {
  source                = "../modules/CodeDeploy"
  platform              = "Server"
  name                  = "App-Deploy"
  deployment_group_name = "App-deployment-group"
  service_role_arn      = module.iam.codedeploy
  alb-name              = module.back-end-alb.alb-name
  autoscaling_groups    = module.app-server.asg-name
}


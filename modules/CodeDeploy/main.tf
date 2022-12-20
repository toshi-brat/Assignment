resource "aws_codedeploy_app" "application" {
  compute_platform = var.platform
  name             = var.name
}

resource "aws_codedeploy_deployment_group" "deployment_group" {
  app_name              = aws_codedeploy_app.application.name
  deployment_group_name = var.deployment_group_name
  deployment_config_name = "CodeDeployDefault.OneAtATime"
  autoscaling_groups     = [var.autoscaling_groups]
  service_role_arn      = var.service_role_arn 
   deployment_style {
    deployment_option = "WITH_TRAFFIC_CONTROL"
    deployment_type   = "IN_PLACE"
  }
  load_balancer_info {
    target_group_info {
      name = var.alb-name
    }
  }

}
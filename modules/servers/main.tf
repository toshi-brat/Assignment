resource "aws_launch_configuration" "server_conf" {
  name_prefix     = "nginx-config"
  image_id        = var.ami
  instance_type   = var.instance-type
  security_groups = [var.sg]
  lifecycle {
    create_before_destroy = true
  }
}
resource "aws_autoscaling_group" "frontend-web-asg" {
  name                      = "external-asg"
  max_size                  = 3
  min_size                  = 1
  health_check_grace_period = 300
  health_check_type         = "ELB"
  desired_capacity          = 2
  force_delete              = true
  launch_configuration      = aws_launch_configuration.server_conf.name
  vpc_zone_identifier       = var.pri-snet
  target_group_arns         = [var.frontend-tg-arn]
  lifecycle {
    create_before_destroy = true
  }
}

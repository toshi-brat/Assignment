
resource "aws_launch_configuration" "web_launch_conf" {
  name_prefix          = var.name
  image_id             = var.web-image-id
  #iam_instance_profile = var.instance-profile
  instance_type               = var.instance-type
  key_name                    = var.key_name
  security_groups             = var.web-sg
 
  #user_data = file("${var.name}.sh")

  lifecycle {
    create_before_destroy = true
  }
}
resource "aws_autoscaling_group" "devops_web_asg" {
  name                 = var.asg-name
  launch_configuration = aws_launch_configuration.web_launch_conf.name
  min_size             = var.min-size
  desired_capacity     = var.desired-size
  max_size             = var.max-size
  health_check_type    = "EC2"
  availability_zones   = ["ap-southeast-1a", "ap-southeast-1b", "ap-southeast-1c"]
  target_group_arns = [var.target-group]

  enabled_metrics = [
    "GroupMinSize",
    "GroupMaxSize",
    "GroupDesiredCapacity",
    "GroupInServiceInstances",
    "GroupTotalInstances"
  ]

  metrics_granularity = "1Minute"

  # vpc_zone_identifier = [
  #   aws_subnet.devops-pub-1a.id,
  #   aws_subnet.devops-pub-1b.id,
  #   aws_subnet.devops-pub-1c.id
  # ]

  lifecycle {
    create_before_destroy = true
  }

}

#ASG Scale-up Policy

# resource "aws_autoscaling_policy" "devops_web_asg_policy_up" {
#   name                   = "devops_web_asg_policy_up"
#   scaling_adjustment     = 1
#   adjustment_type        = "ChangeInCapacity"
#   cooldown               = 300
#   autoscaling_group_name = aws_autoscaling_group.devops_web_asg.name
# }

# resource "aws_cloudwatch_metric_alarm" "devops_web_asg_cpu_alarm_up" {
#   alarm_name          = "devops_web_asg_cpu_alarm_up"
#   comparison_operator = "GreaterThanOrEqualToThreshold"
#   evaluation_periods  = "2"
#   metric_name         = "CPUUtilization"
#   namespace           = "AWS/EC2"
#   period              = "120"
#   statistic           = "Average"
#   threshold           = "80"

#   dimensions = {
#     AutoScalingGroupName = aws_autoscaling_group.devops_web_asg.name
#   }

#   alarm_description = "This metric monitor EC2 instance CPU utilization"
#   alarm_actions     = ["${aws_autoscaling_policy.devops_web_asg_policy_up.arn}"]
# }

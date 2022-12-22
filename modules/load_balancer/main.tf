resource "aws_lb" "uat-lb" {
  name               = "forntend-uat-lb"
  internal           = var.internal
  load_balancer_type = "application"
  security_groups    = [var.lb_sg]
  subnets            = [for v in var.snet: v.snet-id]
  #subnets = [var.snet]
  enable_deletion_protection = false

  # #tags = {
  #   Environment = "uat"
  # }
}
resource "aws_lb_target_group" "tg" {
  name     = var.tg-name
  port     = var.health_check_port
  protocol = "HTTP"
  vpc_id   = var.vpc-id
  health_check {
    port = var.health_check_port
  }
}

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.uat-lb.arn
  port              = "80"
  protocol          = "HTTP"
  # ssl_policy        = "ELBSecurityPolicy-2016-08"
  # certificate_arn   = "arn:aws:iam::187416307283:server-certificate/test_cert_rab3wuqwgja25ct3n4jdj2tzu4"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg.arn
  }
}



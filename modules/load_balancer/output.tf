output "tg-arn" {
    value = aws_lb_target_group.tg.arn  
}

output "alb-name" {
  value = aws_lb.uat-lb.name
}
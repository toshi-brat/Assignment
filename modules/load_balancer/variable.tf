variable "lb_sg" {}

variable "vpc-id" {}
#variable "ec2-id" {}
#variable "pubsnet" {}

variable "snet" {
  type = map
}
variable "internal" {
  
}
variable "tg-name" {
  
}
variable "health_check_port" {
  
}

# variable "attach" {  
#   type = map
# }

# variable "pri-snet" {}
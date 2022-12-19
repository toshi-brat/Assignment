variable "cidr" {
  description = " The desired CIRD range of VPC"
}
# variable "pub-snet" {
#   description = "Desired Public Subnet Ranges"
#     type = map(object({
#     cidr_block          = string
#     availability_zone   = string
# }))
#}

variable "pri-snet" {
  description = "Desired Private Subnet Ranges"
    type = map(object({
    cidr_block          = string
    availability_zone   = string
}))
}
# variable "is_nat_required" {
#   description = "Weather NAT is required in Private Subnet YES/NO "
# }

# variable "nat-pub-id" {
#   description = "Public Subnet Name to Associate with NAT"
# }
# variable "environment" {
#   description = "The envirenment of the Resources"
# }

# variable "buildby" {
#   description = "Code Written By"
# }

variable "pub-cidr" {
  
}
variable "pub-region" {
  
}
variable "is_nat_required" {
  
}

variable "cidr" {
  description = " The desired CIRD range of VPC"
}
variable "pri-snet" {
  description = "Desired Public Subnet Ranges"
  type = map(object({
    cidr_block        = string
    availability_zone = string
  }))
}
variable "pub-snet" {
  description = "Desired Public Subnet Ranges"
  type = map(object({
    cidr_block        = string
    availability_zone = string
  }))
}

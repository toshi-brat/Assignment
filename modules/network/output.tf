output "vpc-id" {
    value = aws_vpc.uat_vpc.id
}
output "cidr_block" {
  value = aws_vpc.uat_vpc.cidr_block
}
output "pri-snet-id" {
value = {for k,v in aws_subnet.pri-snet: k => v.id}
}
output "pub-snet-id" {
value = {for k,v in aws_subnet.pub-snet: k => v.id}
}
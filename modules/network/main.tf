data "aws_availability_zones" "available"{
  state = "available"
}

// vpc resource block

resource "aws_vpc" "uat_vpc" {
  cidr_block       = var.cidr
  instance_tenancy = "default"

#tag = var.#tags
}
############
# PUB-SUBNET
############
resource "aws_subnet" "pub-snet" {
  vpc_id                = aws_vpc.uat_vpc.id
  cidr_block            = var.pub-cidr
  availability_zone     = var.pub-region
  
}
############
# PVT-SUBNET
############
resource "aws_subnet" "pri-snet" {
  vpc_id                = aws_vpc.uat_vpc.id
  for_each              = var.pri-snet
  cidr_block            = each.value["cidr_block"]
  availability_zone     = each.value["availability_zone"]

#tag = var.#tags
}
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.uat_vpc.id

#tag = var.#tags
}

resource "aws_route_table" "pub-rt" {
  vpc_id = aws_vpc.uat_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

#tag = var.#tags
}


resource "aws_route_table_association" "pub-rt-association" {
  subnet_id      = aws_subnet.pub-snet.id
  route_table_id = aws_route_table.pub-rt.id
}

resource "aws_eip" "eip" {
  for_each = aws_subnet.pri-snet
  # #tags = {
  #   Name = "gw NAT"
  # }
  depends_on = [
    aws_subnet.pri-snet
  ]
}

resource "aws_nat_gateway" "nat-gt" {
  for_each = aws_eip.eip
  allocation_id = each.value.id
  
  subnet_id = aws_subnet.pub-snet.id
 #tag = var.#tags

 depends_on = [aws_internet_gateway.igw,aws_eip.eip]
}
resource "aws_route_table" "private" {
  for_each = aws_nat_gateway.nat-gt
  vpc_id = aws_vpc.uat_vpc.id
   route {
    cidr_block = "0.0.0.0/0"
    gateway_id = each.value.id
  }
}
resource "aws_route_table_association" "pri-rt-association" {
  for_each = aws_subnet.pri-snet
  subnet_id      = each.value.id
  route_table_id = aws_route_table.private[each.key].id
  #tag = var.#tags
}

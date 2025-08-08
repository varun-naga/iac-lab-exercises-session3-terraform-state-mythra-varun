data "aws_availability_zones" "available" {}

resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  instance_tenancy     = "default"
  tags = {
    Name = "${var.prefix}-vpc"
  }
}
resource "aws_subnet" "public_subnet" {
  # Create one instance for each subnet
  count  = var.number_of_public_subnets
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = format("%s-public-subnet-${count.index + 1}", var.prefix)
  }
  cidr_block        = cidrsubnet(var.vpc_cidr, 3, count.index)
  availability_zone = data.aws_availability_zones.available.names[count.index]
}
resource "aws_subnet" "private_subnet" {
  # Create one instance for each subnet
  count  = var.number_of_private_subnets
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = format("%s-private-subnet-${count.index + 1}", var.prefix)
  }
  cidr_block        = cidrsubnet(var.vpc_cidr, 3, count.index + 2)
  availability_zone = data.aws_availability_zones.available.names[count.index]
}
resource "aws_subnet" "secure_subnet" {
  # Create one instance for each subnet
  count  = var.number_of_private_subnets
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = format("%s-secure-subnet-${count.index + 1}", var.prefix)
  }
  cidr_block        = cidrsubnet(var.vpc_cidr, 3, count.index + 4)
  availability_zone = data.aws_availability_zones.available.names[count.index]
}
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "${var.prefix}-igw"
  }
}
resource "aws_eip" "nat" {
  //domain="vpc"
  depends_on = [aws_internet_gateway.igw]
}
resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public_subnet[0].id
  tags = {
    Name = format("%s-nat-gw", var.prefix)
  }
}

resource "aws_route_table" "public_routetable" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = format("%s-public-route-table", var.prefix)
  }
}
resource "aws_route_table" "private_routetable" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gw.id
  }
  tags = {
    Name = format("%s-private-route-table", var.prefix)
  }
}
resource "aws_route_table" "secure_routetable" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = format("%s-secure-route-table", var.prefix)
  }
  # route{
  #     cidr_block=var.vpc_cidr
  #     gateway_id = "local"

  # }
}
resource "aws_route_table_association" "public_subnet_association" {
  # for_each = toset(range(var.number_of_public_subnets))
  count          = var.number_of_public_subnets
  subnet_id      = aws_subnet.public_subnet[count.index].id
  route_table_id = aws_route_table.public_routetable.id
}
resource "aws_route_table_association" "private_subnet_association" {
  count          = var.number_of_private_subnets
  subnet_id      = aws_subnet.private_subnet[count.index].id
  route_table_id = aws_route_table.private_routetable.id
}
resource "aws_route_table_association" "secure_subnet_association" {
  count          = var.number_of_secure_subnets
  subnet_id      = aws_subnet.secure_subnet[count.index].id
  route_table_id = aws_route_table.secure_routetable.id
}

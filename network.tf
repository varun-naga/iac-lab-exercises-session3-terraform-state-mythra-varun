resource "aws_vpc" "vpc"{
    cidr_block=var.vpc_cidr
    enable_dns_support   = "true"
    enable_dns_hostnames = "true"
    instance_tenancy     = "default"
    tags={
        Name="${var.prefix}-vpc"    
    }
}
resource "aws_subnet" "public_subnet1" {
    vpc_id=aws_vpc.vpc.id
    cidr_block=var.subnet1_cidr
    availability_zone=format("%sa",var.region)
    map_public_ip_on_launch=true
    tags={
        Name=format("%s-public-subnet-1",var.prefix)
    }
}
resource "aws_subnet" "public_subnet2"{
    vpc_id=aws_vpc.vpc.id
    cidr_block=var.subnet2_cidr
    availability_zone=format("%sb",var.region)
    map_public_ip_on_launch = "true"
    tags={
        Name=format("%s-public-subnet-2",var.prefix)
    }
}
resource "aws_subnet" "private_subnet1"{
    vpc_id = aws_vpc.vpc.id
    cidr_block=var.subnet3_cidr
    availability_zone=format("%sa",var.region)
    map_public_ip_on_launch = "false"
    tags={
        Name=format("%s-private-subnet-1",var.prefix)
    }
}
resource "aws_subnet" "private_subnet2"{
    vpc_id=aws_vpc.vpc.id
    cidr_block=var.subnet4_cidr
    availability_zone=format("%sb",var.region)
    map_public_ip_on_launch = "false"
    tags={
        Name=format("%s-private-subnet-2",var.prefix)
    }
}
resource "aws_subnet" "secure_subnet1" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = var.subnet5_cidr
  availability_zone = format("%sa", var.region)
  map_public_ip_on_launch = "false"
  tags={
    Name=format("%s-secure-subnet-1",var.prefix)
  }
}
resource "aws_subnet" "secure_subnet2"{
    vpc_id=aws_vpc.vpc.id
    cidr_block=var.subnet6_cidr
    availability_zone=format("%sb",var.region)
    map_public_ip_on_launch = "false"
    tags={
        Name=format("%s-secure-subnet-2",var.prefix)
    }
}
resource "aws_internet_gateway" "igw"{
    vpc_id=aws_vpc.vpc.id
    tags={
        Name="${var.prefix}-igw"
    }
}
resource "aws_eip" "nat"{
   //domain="vpc"
   depends_on = [ aws_internet_gateway.igw ]
}
resource "aws_nat_gateway" "nat_gw"{
    allocation_id=aws_eip.nat.id
    subnet_id = aws_subnet.public_subnet1.id
    tags={
        Name=format("%s-nat-gw",var.prefix)
    }
}

resource "aws_route_table""public_routetable"{
    vpc_id=aws_vpc.vpc.id
    route{
        cidr_block="0.0.0.0/0"
        gateway_id=aws_internet_gateway.igw.id
    }
    tags={
        Name=format("%s-public-route-table",var.prefix)
    }
}
resource "aws_route_table""private_routetable"{
    vpc_id=aws_vpc.vpc.id
    route{
        cidr_block="0.0.0.0/0"
        nat_gateway_id=aws_nat_gateway.nat_gw.id
    }
    tags={
        Name=format("%s-private-route-table",var.prefix)
    }
}
resource "aws_route_table" "secure_routetable"{
    vpc_id=aws_vpc.vpc.id
    # route{
    #     cidr_block=var.vpc_cidr
    #     gateway_id = "local"
        
    # }
}
resource "aws_route_table_association" "public_subnet_1_accociation" {
    subnet_id=aws_subnet.public_subnet1.id
    route_table_id=aws_route_table.public_routetable.id
}
resource "aws_route_table_association" "public_subnet_2_association"{
    subnet_id=aws_subnet.public_subnet2.id
    route_table_id=aws_route_table.public_routetable.id
}
resource "aws_route_table_association" "private_subnet_1_association" {
    subnet_id=aws_subnet.private_subnet1.id
    route_table_id=aws_route_table.private_routetable.id
}
resource "aws_route_table_association" "private_subnet_2_association"{
    subnet_id=aws_subnet.private_subnet2.id
    route_table_id=aws_route_table.private_routetable.id
}
resource "aws_route_table_association" "secure_subnet_1_association"{
    subnet_id=aws_subnet.secure_subnet1.id
    route_table_id = aws_route_table.secure_routetable.id
}
resource "aws_route_table_association" "secure_subnet_2_association"{
    subnet_id=aws_subnet.secure_subnet2.id
    route_table_id = aws_route_table.secure_routetable.id
}
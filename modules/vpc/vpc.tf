resource "aws_vpc" "VPC" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"
  tags = {
    Name    = "VPC"
    Project = "Personio_challenge"
  }
}

resource "aws_internet_gateway" "IGW" {
  vpc_id = aws_vpc.VPC.id
  tags = {
    Name    = "IGW"
    Project = "Personio_challenge"
  }
}

resource "aws_subnet" "PublicSubnet1" {
  vpc_id            = aws_vpc.VPC.id
  cidr_block        = var.public_subnet_cidrs[0]
  availability_zone = var.availability_zones[0]
  map_public_ip_on_launch = true
  tags = {
    Name    = "PublicSubnet1"
    Project = "Personio_challenge"
  }
}

resource "aws_subnet" "PublicSubnet2" {
  vpc_id            = aws_vpc.VPC.id
  cidr_block        = var.public_subnet_cidrs[1]
  availability_zone = var.availability_zones[1]
  map_public_ip_on_launch = true
  tags = {
    Name    = "PublicSubnet2"
    Project = "Personio_challenge"
  }
}

resource "aws_subnet" "PrivateSubnet1" {
  vpc_id            = aws_vpc.VPC.id
  cidr_block        = var.private_subnet_cidrs[0]
  availability_zone = var.availability_zones[0]
  tags = {
    Name    = "PrivateSubnet1"
    Project = "Personio_challenge"
  }
}
resource "aws_subnet" "PrivateSubnet2" {
  vpc_id            = aws_vpc.VPC.id
  cidr_block        = var.private_subnet_cidrs[1]
  availability_zone = var.availability_zones[1]
  tags = {
    Name    = "PrivateSubnet2"
    Project = "Personio_challenge"
  }
}

resource "aws_route_table" "PublicRT" {
  vpc_id = aws_vpc.VPC.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.IGW.id
  }
  tags = {
    Name    = "PublicRT"
    Project = "Personio_challenge"
  }
}
resource "aws_route_table" "PrivateRT1" {
  vpc_id = aws_vpc.VPC.id
  tags = {
    Name    = "PrivateRT1"
    Project = "Personio_challenge"
  }
}
resource "aws_route_table" "PrivateRT2" {
  vpc_id = aws_vpc.VPC.id
  tags = {
    Name    = "PrivateRT2"
    Project = "Personio_challenge"
  }
}

resource "aws_route_table_association" "PublicRTassociation1" {
  subnet_id      = aws_subnet.PublicSubnet1.id
  route_table_id = aws_route_table.PublicRT.id
}
resource "aws_route_table_association" "PublicRTassociation2" {
  subnet_id      = aws_subnet.PublicSubnet2.id
  route_table_id = aws_route_table.PublicRT.id
}
resource "aws_route_table_association" "PrivateRTassociation1" {
  subnet_id      = aws_subnet.PrivateSubnet1.id
  route_table_id = aws_route_table.PrivateRT1.id
}
resource "aws_route_table_association" "PrivateRTassociation2" {
  subnet_id      = aws_subnet.PrivateSubnet2.id
  route_table_id = aws_route_table.PrivateRT2.id
}

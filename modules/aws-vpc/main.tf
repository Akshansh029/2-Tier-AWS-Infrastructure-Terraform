# VPC
resource "aws_vpc" "2-tier-vpc" {
  cidr_block       = var.vpc-cidr  # "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = var.vpc-name
  }
}

# Internet Gateway 
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.2-tier-vpc.id

  tags = {
    Name = var.igw-name
  }

  depends_on = [ aws_vpc.2-tier-vpc ]
}

# Public subnet 1 for Web Tier
resource "aws_subnet" "public-subnet1" {
  vpc_id     = aws_vpc.2-tier-vpc.id
  cidr_block = var.public-subnet-cidr1 # "10.0.1.0/24"
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = var.public-subnet1-name
  }

  depends_on = [ aws_internet_gateway.igw ]
}

# Public subnet 2 for Web Tier
resource "aws_subnet" "public-subnet2" {
  vpc_id     = aws_vpc.2-tier-vpc.id
  cidr_block = var.public-subnet-cidr2 # "10.0.1.0/24"
  availability_zone = "us-east-1b"
  map_public_ip_on_launch = true

  tags = {
    Name = var.public-subnet2-name
  }

  depends_on = [ aws_subnet.public-subnet1 ]
}

# Private subnet 1 for DB Tier
resource "aws_subnet" "private-subnet1" {
  vpc_id     = aws_vpc.2-tier-vpc.id
  cidr_block = var.private-subnet-cidr1 # "10.0.1.0/24"
  availability_zone = "us-east-1b"

  tags = {
    Name = var.private-subnet1-name
  }

  depends_on = [ aws_subnet.public-subnet2 ]
}

# Private subnet 2 for DB Tier
resource "aws_subnet" "private-subnet2" {
  vpc_id     = aws_vpc.2-tier-vpc.id
  cidr_block = var.private-subnet-cidr2 # "10.0.1.0/24"
  availability_zone = "us-east-1b"

  tags = {
    Name = var.private-subnet2-name
  }

  depends_on = [ aws_subnet.private-subnet1 ]
}

# Elastic IP for NAT Gateway 1
resource "aws_eip" "eip1" {
  domain   = "vpc"

  tags = {
    "Name" = var.eip1-name
  }

  depends_on = [ aws_subnet.private-subnet2 ]
}

# Elastic IP for NAT Gateway 2
resource "aws_eip" "eip2" {
  domain   = "vpc"

  tags = {
    "Name" = var.eip2-name
  }

  depends_on = [ aws_eip.eip1 ]
}

# NAT gateway 1 for private-subnet1
resource "aws_nat_gateway" "nat-gw1" {
  allocation_id = aws_eip.eip1
  subnet_id     = aws_subnet.public-subnet1

  tags = {
    Name = var.nat-gw1-name
  }

  depends_on = [aws_eip.eip1]
}

# NAT gateway 2 for private-subnet2
resource "aws_nat_gateway" "nat-gw2" {
  allocation_id = aws_eip.eip2
  subnet_id     = aws_subnet.public-subnet2

  tags = {
    Name = var.nat-gw2-name
  }

  depends_on = [ aws_eip.eip2, aws_nat_gateway.nat-gw1 ]
}

# Route table 1 for Public subnet 
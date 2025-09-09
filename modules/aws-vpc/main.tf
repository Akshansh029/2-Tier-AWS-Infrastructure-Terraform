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
  allocation_id = aws_eip.eip1.id
  subnet_id     = aws_subnet.public-subnet1.id

  tags = {
    Name = var.nat-gw1-name
  }

  depends_on = [aws_eip.eip1]
}

# NAT gateway 2 for private-subnet2
resource "aws_nat_gateway" "nat-gw2" {
  allocation_id = aws_eip.eip2.id
  subnet_id     = aws_subnet.public-subnet2.id

  tags = {
    Name = var.nat-gw2-name
  }

  depends_on = [ aws_eip.eip2, aws_nat_gateway.nat-gw1 ]
}

# Route table 1 for Public subnet 
resource "aws_route_table" "public-rt1" {
  vpc_id = aws_vpc.2-tier-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = var.public-rt1-name
  }
}

# Associate of Public Route Table 1
resource "aws_route_table_association" "public-rt1-association" {
  subnet_id      = aws_subnet.public-subnet1.id
  route_table_id = aws_route_table.public-rt1.id

  depends_on = [ aws_route_table.public-rt1 ]
}

# Route table 2 for Public subnet 
resource "aws_route_table" "public-rt2" {
  vpc_id = aws_vpc.2-tier-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = var.public-rt2-name
  }

  depends_on = [ aws_route_table_association.public-rt1-association ]
}

# Associate of Public Route Table 2
resource "aws_route_table_association" "public-rt2-association" {
  subnet_id      = aws_subnet.public-subnet2.id
  route_table_id = aws_route_table.public-rt2.id

  depends_on = [ aws_route_table.public-rt2 ]
}

# Route table 1 for Private subnet 
resource "aws_route_table" "private-rt1" {
  vpc_id = aws_vpc.2-tier-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat-gw1.id
  }

  tags = {
    Name = var.private-rt1-name
  }

  depends_on = [ aws_route_table_association.public-rt2-association ]
}

# Associate of Private Route Table 2
resource "aws_route_table_association" "private-rt1-association" {
  subnet_id      = aws_subnet.private-subnet1.id
  route_table_id = aws_route_table.private-rt1.id

  depends_on = [ aws_route_table.private-rt1 ]
}

# Route table 2 for Private subnet 
resource "aws_route_table" "private-rt2" {
  vpc_id = aws_vpc.2-tier-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat-gw2.id
  }

  tags = {
    Name = var.private-rt2-name
  }

  depends_on = [ aws_route_table_association.private-rt1-association ]
}

# Associate of Private Route Table 2
resource "aws_route_table_association" "private-rt2-association" {
  subnet_id      = aws_subnet.private-subnet2.id
  route_table_id = aws_route_table.private-rt2

  depends_on = [ aws_route_table.private-rt1 ]
}
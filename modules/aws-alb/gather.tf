data "aws_vpc" "vpc" {
  filter {
    name   = "tag:Name"
    values = [var.vpc-name]
  }
}

data "aws_subnet" "public-subnet1" {
  filter {
    name = "tag:Name"
    values = [var.public-subnet1-name]
  }
}

data "aws_subnet" "public-subnet2" {
  filter {
    name = "tag:Name"
    values = [var.public-subnet2-name]
  }
}

data "aws_security_group" "web-alg-sg" {
  filter {
    name = "tag:Name"
    values = [var.web-alb-sg-name]
  }
}
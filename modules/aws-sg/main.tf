# Security group for Load Balancer
resource "aws_security_group" "alb-sg" {
  vpc_id      = data.aws_vpc.vpc.id
  description = "Allow HTTP traffic"

  ingress {
      from_port = 80
      to_port = 80
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
      from_port = 443
      to_port = 443
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = var.alb-sg-name
  }
}

# Security group for Web Tier EC2 instances
resource "aws_security_group" "web-tier-sg" {
  vpc_id      = data.aws_vpc.vpc.id
  description = "Allow HTTP traffic"

  ingress {
      from_port = 80
      to_port = 80
      protocol = "tcp"
      security_groups = [aws_security_group.alb-sg.id]
  }

  ingress {
      from_port = 443
      to_port = 443
      protocol = "tcp"
      security_groups = [aws_security_group.alb-sg.id]
  }

  egress {
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = var.web-sg-name
  }
}

# Security group for DB Tier RDS instances
resource "aws_security_group" "db-tier-sg" {
  vpc_id      = data.aws_vpc.vpc.id
  description = "Allow HTTP traffic"

  ingress {
      from_port = 80
      to_port = 80
      protocol = "tcp"
      security_groups = [aws_security_group.web-tier-sg.id]
  }

  ingress {
      from_port = 443
      to_port = 443
      protocol = "tcp"
      security_groups = [aws_security_group.web-tier-sg.id]
  }

  egress {
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = var.rds-sg-name
  }
}
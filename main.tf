# VPC creation
module "vpc" {
  source = "./modules/aws-vpc"

  vpc-name = var.VPC-NAME
  vpc-cidr = var.VPC-CIDR
  public-subnet1-name = var.PUBLIC-SUBNET1-NAME
  public-subnet2-name = var.PUBLIC-SUBNET2-NAME
  private-subnet1-name = var.PRIVATE-SUBNET1-NAME
  private-subnet2-name = var.PRIVATE-SUBNET2-NAME
  public-subnet-cidr1 = var.PUBLIC-SUBNET-CIDR1
  public-subnet-cidr2 = var.PUBLIC-SUBNET-CIDR2
  private-subnet-cidr1 = var.PRIVATE-SUBNET-CIDR1
  private-subnet-cidr2 = var.PRIVATE-SUBNET-CIDR2
  igw-name = var.IGW-NAME
  eip1-name = var.EIP1-NAME
  eip2-name = var.EIP2-NAME
  nat-gw1-name = var.NAT-GW1-NAME
  nat-gw2-name = var.NAT-GW2-NAME
  public-rt1-name = var.PUBLIC-RT1-NAME
  public-rt2-name = var.PUBLIC-RT2-NAME
  private-rt1-name = var.PRIVATE-RT1-NAME
  private-rt2-name = var.PRIVATE-RT2-NAME
}

# Security Groups creation
module "security-group" {
  source = "./modules/aws-sg"

  vpc-name = var.VPC-NAME
  alb-sg-name = var.ALB-SG-NAME
  web-sg-name = var.WEB-SG-NAME
  rds-sg-name = var.DB-SG-NAME

  depends_on = [ module.vpc ]
}

# RDS Cluster and Instance creation
module "rds" {
  source = "./modules/aws-rds"

  sg-name = var.SG-NAME
  db-sg-name = var.DB-SG-NAME
  private-subnet1-name = var.PRIVATE-SUBNET1-NAME
  private-subnet2-name = var.PRIVATE-SUBNET2-NAME
  rds-username = var.RDS-USERNAME
  rds-password = var.RDS-PASSWORD
  rds-cluster-name = var.RDS-CLUSTER-NAME
  db-name = var.DB-NAME

  depends_on = [ module.security-group ]
}

# ALB creation
module "alb" {
  source = "./modules/aws-alb"

  vpc-name = var.VPC-NAME
  public-subnet1-name = var.PUBLIC-SUBNET1-NAME
  public-subnet2-name = var.PUBLIC-SUBNET2-NAME
  web-alb-name = var.WEB-ALB-NAME
  web-alb-sg-name = var.WEB-SG-NAME
  web-alb-tg-name = var.WEB-ALB-TG-NAME

  depends_on = [ module.rds ]
}

# IAM creation
module "iam" {
  source = "./modules/aws-iam"

  iam-profile-name = var.IAM-PROFILE-NAME
  iam-policy = var.IAM-POLICY
  iam-role = var.IAM-ROLE

  depends_on = [ module.alb ]
}

# ASG creation
module "asg" {
  source = "./modules/aws-auto-scaling"

  web-asg-name = var.WEB-SG-NAME
  launch-template-name = var.LAUNCH-TEMPLATE-NAME
  ami-name = var.AMI-NAME
  web-sg-name = var.WEB-ASG-NAME
  public-subnet1-name = var.PUBLIC-SUBNET1-NAME
  public-subnet2-name = var.PUBLIC-SUBNET2-NAME
  tg-name = var.TG-NAME
  instance-profile-name = var.INSTANCE-PROFILE-NAME

  depends_on = [ module.iam ]
}
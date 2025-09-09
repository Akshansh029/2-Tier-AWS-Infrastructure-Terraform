"aws_region" = "us-east-1"

# VPC vars
"VPC-NAME" = "2-tier-infra-vpc" 
"VPC-CIDR" = "10.0.0.0/16"
"PUBLIC-SUBNET-CIDR1" = "10.0.1.0/24"
"PUBLIC-SUBNET-CIDR2" = "10.0.2.0/24"
"PRIVATE-SUBNET-CIDR1" = "10.0.3.0/24"
"PRIVATE-SUBNET-CIDR2" = "10.0.4.0/24"
"PUBLIC-SUBNET1-NAME" = "2-tier-public-subnet1"
"PUBLIC-SUBNET2-NAME" = "2-tier-public-subnet2"
"PRIVATE-SUBNET1-NAME" = "2-tier-private-subnet1"
"PRIVATE-SUBNET2-NAME" = "2-tier-private-subnet1"
"IGW-NAME" = "2-tier-infra-igw"
"EIP1-NAME" = "2-tier-elastic-ip1"
"EIP2-NAME" = "2-tier-elastic-ip2"
"NAT-GW1-NAME" = "2-tier-nat-gw1"
"NAT-GW2-NAME" = "2-tier-nat-gw2"
"PUBLIC-RT1-NAME" = "2-tier-public-route-table1"
"PUBLIC-RT2-NAME" = "2-tier-public-route-table2"
"PRIVATE-RT1-NAME" = "2-tier-private-route-table1"
"PRIVATE-RT2-NAME" = "2-tier-private-route-table2"

# SG vars
"ALB-SG-NAME" = "2-tier-alb-sg"
"WEB-SG-NAME" = "2-tier-web-sg"
"DB-SG-NAME" = "2-tier-db-sg"

# RDS vars
"SG-NAME" = "2-tier-rds-sg"
"RDS-USERNAME" = ${{ secrets.RDS_USERNAME }}
"RDS-PASSWORD" = ${{ secrets.RDS_PASSWORD }}
"RDS-CLUSTER-NAME" = "2-tier-rds-cluster"
"DB-NAME" = "mydb"

# ALB
"WEB-ALB-NAME" = "2-tier-web-alb"
"WEB-ALB-TG-NAME" = "2-tier-alb-tg"

# IAM
"IAM-PROFILE-NAME" = "IAM-instance-profile-for-ec2-SSM"
"IAM-POLICY" = "IAM-policy-for-ec2-SSM"
"IAM-ROLE" = "IAM-role-for-ec2-SSM"

# ASG
"WEB-ASG-NAME" = "2-tier-asg"
"LAUNCH-TEMPLATE-NAME" = "web-launch-template"
"AMI-NAME" = "ec2-ami"
"TG-NAME" = "2-tier-asg-tg"
"INSTANCE-PROFILE-NAME" = "2-tier-instance-profile"
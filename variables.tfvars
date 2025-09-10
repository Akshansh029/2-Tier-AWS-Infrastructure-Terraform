# VPC vars
VPC-NAME = "two-tier-infra-vpc" 
VPC-CIDR = "10.0.0.0/16"
PUBLIC-SUBNET-CIDR1 = "10.0.1.0/24"
PUBLIC-SUBNET-CIDR2 = "10.0.2.0/24"
PRIVATE-SUBNET-CIDR1 = "10.0.3.0/24"
PRIVATE-SUBNET-CIDR2 = "10.0.4.0/24"
PUBLIC-SUBNET1-NAME = "two-tier-public-subnet1"
PUBLIC-SUBNET2-NAME = "two-tier-public-subnet2"
PRIVATE-SUBNET1-NAME = "two-tier-private-subnet1"
PRIVATE-SUBNET2-NAME = "two-tier-private-subnet2"
IGW-NAME = "two-tier-infra-igw"
EIP1-NAME = "two-tier-elastic-ip1"
EIP2-NAME = "two-tier-elastic-ip2"
NAT-GW1-NAME = "two-tier-nat-gw1"
NAT-GW2-NAME = "two-tier-nat-gw2"
PUBLIC-RT1-NAME = "two-tier-public-route-table1"
PUBLIC-RT2-NAME = "two-tier-public-route-table2"
PRIVATE-RT1-NAME = "two-tier-private-route-table1"
PRIVATE-RT2-NAME = "two-tier-private-route-table2"

# SG vars
ALB-SG-NAME = "two-tier-alb-sg"
WEB-SG-NAME = "two-tier-web-sg"
DB-SG-NAME = "two-tier-db-sg"

# RDS vars
SG-NAME = "two-tier-rds-sg"
RDS-USERNAME = "akshansh029"
RDS-PASSWORD = "akshansh029-rds"
RDS-CLUSTER-NAME = "two-tier-rds-cluster"
DB-NAME = "mydb"

# ALB
WEB-ALB-NAME = "two-tier-web-alb"
WEB-ALB-TG-NAME = "two-tier-alb-tg"

# IAM
IAM-PROFILE-NAME = "two-tier-IAM-instance-profile-for-ec2-SSM"
IAM-POLICY = "two-tier-IAM-policy-for-ec2-SSM"
IAM-ROLE = "two-tier-IAM-role-for-ec2-SSM"

# ASG
WEB-ASG-NAME = "two-tier-asg"
LAUNCH-TEMPLATE-NAME = "web-launch-template"
AMI-NAME = "ec2-ami"
TG-NAME = "two-tier-alb-tg"
INSTANCE-PROFILE-NAME = "two-tier-IAM-instance-profile-for-ec2-SSM"
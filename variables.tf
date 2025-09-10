# VPC vars
variable "VPC-NAME" {}
variable "VPC-CIDR" {}
variable "PUBLIC-SUBNET-CIDR1" {}
variable "PUBLIC-SUBNET-CIDR2" {}
variable "PRIVATE-SUBNET-CIDR1" {}
variable "PRIVATE-SUBNET-CIDR2" {}
variable "PUBLIC-SUBNET1-NAME" {}
variable "PUBLIC-SUBNET2-NAME" {}
variable "PRIVATE-SUBNET1-NAME" {}
variable "PRIVATE-SUBNET2-NAME" {}
variable "IGW-NAME" {}
variable "EIP1-NAME" {}
variable "EIP2-NAME" {}
variable "NAT-GW1-NAME" {}
variable "NAT-GW2-NAME" {}
variable "PUBLIC-RT1-NAME" {}
variable "PUBLIC-RT2-NAME" {}
variable "PRIVATE-RT1-NAME" {}
variable "PRIVATE-RT2-NAME" {}

# SG vars
variable "ALB-SG-NAME" {}
variable "WEB-SG-NAME" {}
variable "DB-SG-NAME" {}

# RDS vars
variable "SG-NAME" {}
variable "RDS-USERNAME" {}
variable "RDS-PASSWORD" {}
variable "RDS-CLUSTER-NAME" {}
variable "DB-NAME" {}

# ALB
variable "WEB-ALB-NAME" {}
variable "WEB-ALB-TG-NAME" {}

# IAM
variable "IAM-PROFILE-NAME" {}
variable "IAM-POLICY" {}
variable "IAM-ROLE" {}

# ASG
variable "WEB-ASG-NAME" {}
variable "LAUNCH-TEMPLATE-NAME" {}
variable "AMI-NAME" {}
variable "TG-NAME" {}
variable "INSTANCE-PROFILE-NAME" {}
# Gathers information about the specified resources and returns data about the resources, for example 
# data.aws_vpc.vpc.id — the VPC ID (e.g. vpc-0abc1234)
# data.aws_vpc.vpc.cidr_block — the VPC CIDR
# data.aws_vpc.vpc.tags — map of tags
# data.aws_vpc.vpc.default_security_group_id, etc.

data "aws_vpc" "vpc" {
  filter {
    name   = "tag:Name"
    values = [var.vpc-name]
  }
}
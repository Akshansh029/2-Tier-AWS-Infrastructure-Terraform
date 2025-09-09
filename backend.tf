terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.12.0"
    }
  }

  backend "s3" {
    bucket = "terraform-remote-infra-bucket-akshansh029"
    key = "2-Tier-Project/terraform.tfstate"
    region = "us-east-1"
    dynamodb_table = "terraform-remote-infra-table"
  }
}
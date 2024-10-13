terraform {
  required_version = "= 1.9.7"

  # Switch to remote backend
  backend "s3" {
    bucket  = "nicko-terraform-state-bucket"
    key     = "state/terraform.tfstate"
    region  = "eu-central-1"
    encrypt = true
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "= 5.70.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

# VPC Module
module "vpc" {
  source = "../modules/vpc"

  vpc_name = "my-vpc"
  cidr     = var.vpc_cidr
}

# Subnets Module
module "subnets" {
  source = "../modules/subnets"

  vpc_id               = module.vpc.vpc_id
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
}

# Internet Gateway Module
module "internet_gateway" {
  source = "../modules/internet_gateway"

  vpc_id = module.vpc.vpc_id
}

# NAT Gateway Module
module "nat_gateway" {
  source = "../modules/nat_gateway"

  vpc_id           = module.vpc.vpc_id
  public_subnet_id = module.subnets.public_subnet_ids[0]
}

# Security Groups Module
module "security_groups" {
  source = "../modules/security_groups"

  vpc_id             = module.vpc.vpc_id
  public_subnet_ids  = module.subnets.public_subnet_ids
  private_subnet_ids = module.subnets.private_subnet_ids
}

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
  region = var.region
}

module "vpc" {
  source               = "../modules/vpc"
  cidr_block           = var.cidr_block
  public_subnet_count  = var.public_subnet_count
  private_subnet_count = var.private_subnet_count
  public_subnets       = var.public_subnets
  private_subnets      = var.private_subnets
  azs                  = var.azs
  region               = var.region
}

module "security_groups" {
  source = "../modules/security-groups"
  vpc_id = module.vpc.vpc_id # Correctly referencing VPC ID output
}

module "ec2" {
  source            = "../modules/ec2"
  ami               = var.ami
  instance_type     = var.instance_type
  key_name          = var.key_name
  bastion_sg_id     = module.security_groups.bastion_sg_id # Ensure this matches the output in the security group module
  k3s_sg_id         = module.security_groups.k3s_sg_id     # Ensure this matches the output in the security group module
  subnet_id         = module.vpc.public_subnets[0]
  private_subnet_id = module.vpc.private_subnets[0]
}

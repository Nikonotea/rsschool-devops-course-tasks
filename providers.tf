terraform {
  required_version = ">= 1.0, < 2.0"

  backend "s3" {
    bucket  = "nicko-terraform-state-bucket"
    key     = "state/terraform.tfstate"
    region  = "eu-central-1"
    encrypt = true
    acl     = "private"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.70.0, < 6.0.0"
    }
  }
}

provider "aws" {
  region = "eu-central-1"
}
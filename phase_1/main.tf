terraform {
  required_version = "= 1.9.7"

  # Use local backend for phase 1
  backend "local" {
    path = "terraform.tfstate"
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

module "s3_bucket" {
  source      = "../s3bucket"
  bucket_name = var.bucket_name
  environment = var.environment
}

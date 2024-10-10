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

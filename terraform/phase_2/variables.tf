variable "aws_region" {
  description = "AWS region"
  type        = string
}

variable "account_id" {
  description = "AWS Account ID"
  type        = string
}

variable "github_org" {
  description = "GitHub Organization"
  type        = string
}

variable "github_repo" {
  description = "GitHub Repository"
  type        = string
}

variable "github_oidc_thumbprint" {
  description = "Thumbprint for GitHub OIDC provider"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "public_subnet_cidrs" {
  description = "List of public subnet CIDRs"
  type        = list(string)
}

variable "private_subnet_cidrs" {
  description = "List of private subnet CIDRs"
  type        = list(string)
}

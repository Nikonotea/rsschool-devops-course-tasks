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
  default     = "6938fd4d98bab03faadb97b34396831e3780aea1"
}
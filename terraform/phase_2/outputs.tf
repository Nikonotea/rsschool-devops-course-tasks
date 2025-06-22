output "github_actions_oidc_provider_arn" {
  description = "The ARN of the OIDC provider for GitHub Actions"
  value       = aws_iam_openid_connect_provider.github_actions.arn
}

output "github_actions_role_arn" {
  description = "The ARN of the IAM role used by GitHub Actions"
  value       = aws_iam_role.github_actions_role.arn
}

output "vpc_id" {
  value = module.vpc.vpc_id
}

output "private_subnet_ids" {
  value = module.subnets.private_subnet_ids
}

output "public_subnet_ids" {
  value = module.subnets.public_subnet_ids
}

output "nat_gateway_ip" {
  value = module.nat_gateway.nat_ip
}

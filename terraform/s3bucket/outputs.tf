# Output the S3 bucket name directly from the resource inside the module
output "bucket_name" {
  value       = aws_s3_bucket.terraform_state.bucket
  description = "The name of the S3 bucket created for Terraform state"
}

# Output the S3 bucket ARN
output "bucket_arn" {
  value       = aws_s3_bucket.terraform_state.arn
  description = "The ARN of the S3 bucket created for Terraform state"
}

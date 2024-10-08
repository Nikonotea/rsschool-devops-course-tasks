# S3 Bucket Resource without ACL management
resource "aws_s3_bucket" "terraform_state" {
  bucket = "nicko-terraform-state-bucket"

  tags = {
    Name        = "Terraform State Bucket"
    Environment = "Dev"
  }

  lifecycle {
    prevent_destroy = true # Prevent accidental destruction of the bucket
  }
}

# Separate resource for server-side encryption configuration
resource "aws_s3_bucket_server_side_encryption_configuration" "terraform_state_encryption" {
  bucket = aws_s3_bucket.terraform_state.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256" # Encryption algorithm for the bucket
    }
  }
}

# Separate resource for versioning with corrected versioning_configuration block
resource "aws_s3_bucket_versioning" "terraform_state_versioning" {
  bucket = aws_s3_bucket.terraform_state.id

  versioning_configuration {
    status = "Enabled"
  }
}

# Block public access configuration
resource "aws_s3_bucket_public_access_block" "public_access_block" {
  bucket = aws_s3_bucket.terraform_state.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

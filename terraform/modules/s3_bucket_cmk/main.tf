data "terraform_remote_state" "kms" {
  backend = "s3"

  config = {
    bucket     = var.backend_bucket
    key        = "${var.backend_path}/backend/kms"
    region     = var.region
    #role_arn   = var.role_arn
  }
}
resource "aws_s3_bucket" "s3_bucket" {
  bucket = var.bucket_name

  tags = merge(
    {
      Name        = var.bucket_name
      Environment = var.environment
    },
    var.s3_tags
  )
}

# Default encryption using CMK
resource "aws_s3_bucket_server_side_encryption_configuration" "s3_bucket" {
  bucket = aws_s3_bucket.s3_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = data.terraform_remote_state.kms.outputs.key_arn
      sse_algorithm     = "aws:kms"
    }
  }
}

# (Optional) Block public access
resource "aws_s3_bucket_public_access_block" "s3_bucket" {
  bucket = aws_s3_bucket.s3_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

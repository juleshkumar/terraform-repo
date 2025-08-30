module "s3_bucket_cmk" {
  source       = "../../../modules/s3_bucket_cmk"
  bucket_name = var.bucket_name
  backend_bucket = var.backend_bucket
  backend_path = var.backend_path
  environment = var.environment
  s3_tags = var.s3_tags
  region = var.region
}

variable "bucket_name" {
  description = "The name of the S3 bucket"
  type        = string
}

variable "backend_bucket" {
  description = "s3 backend bucket name"
  type        = string
}

variable "backend_path" {
  description = "backend bucket folder path"
  type        = string
}

variable "region" {
  description = "Region for s3 bucket"
  type        = string
}

variable "environment" {
  description = "Environment name (e.g., dev, prod)"
  type        = string
}

variable "s3_tags" {
  description = "Additional tags for the S3 bucket"
  type        = map(string)
  default     = {}
}

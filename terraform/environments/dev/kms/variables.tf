variable "kms_key_name" {
  type        = string
  description = "(optional) describe your variable"
}

variable "region" {
  type = string
}

variable "kms_tags" {
  type = map(string)
  
}


variable "account_id" {
  description = "AWS Account ID"
  type        = string
}
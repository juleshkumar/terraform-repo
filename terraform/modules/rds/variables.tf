variable "gyan_bharatam_db_instance_identifier" {
  type        = string
  description = "Please mention the Database Instance Identifier"
}

variable "gyan_bharatam_database_name" {
  type        = string
  description = "gyan_bharatam Database Name"
}

variable "rds_secret_name" {
  type        = string
  description = "gyan_bharatam secret manager name"
}


variable "major_version" {
  type        = string
  description = "gyan_bharatam Database Parameter Group Major Version"
}

variable "engine_version" {
  type        = string
  description = "gyan_bharatam Database Engine Version"
}

variable "gyan_bharatam_db_security_group" {
  type        = string
  description = "gyan_bharatam Database Security Group"
}

variable "gyan_bharatam_db_instance_type" {
  type        = string
  description = "gyan_bharatam Database Instance Type"
}

variable "gyan_bharatam_db_allocated_storage" {
  type        = string
  description = "gyan_bharatam Database Storage Size"
}

variable "rds_port" {
  type        = string
  description = "custom port"
}

variable "region" {
  type = string
}

variable "backend_bucket" {
  type = string
}

variable "rds_tags" {
  type = map(string)
}

variable "rds_multi_az" {
  type        = bool
  description = "(optional) describe your variable"
}


 variable "backend_path" {
  description = "The name of the cluster"
  type        = string
}



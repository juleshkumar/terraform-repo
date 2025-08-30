#AWS Account Number
variable "ami" {
  type        = string
  description = "The ID of the Amazon Machine Image (AMI) used to launch the instance"
}

variable "customer_name" {
  type        = string
  description = "The name of the customer"
}

variable "ec2_instance_type" {
  type        = string
  description = "The type of EC2 instance to launch"
}

variable "js_user" {
  type        = string
  description = "jumpser username"
}

variable "jumpbox_tags" {
  type = map(string)
}

 variable "backend_path" {
  description = "The name of the cluster"
  type        = string
}


variable "region" {
  type = string
}

variable "backend_bucket" {
  type = string
}

variable "environment" {
  type = string
  description = "Environment name"
}

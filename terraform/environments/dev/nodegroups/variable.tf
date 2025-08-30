variable "cluster-name" {
  description = "The name of the EKS cluster"
  type        = string
}

variable "cloudwatch_logs" {
  type        = bool
  description = "Setup full CloudWatch logging."
}

variable "backend_path" {
  type        = string
  description = "File path to the backend key file."
}

variable "environment" {
  type        = string
  description = "The environment name (e.g., production, staging)."
}


variable "region" {
  type        = string
  description = "The AWS region to deploy the EKS cluster."
}

variable "customer_name" {
  type        = string
  description = "Enter name of the customer"
}

variable "ec2_root_volume_size" {
  type        = string
}

variable "nodegroup_name" {
  type        = string
}

variable "service_cidr" {
  type        = string
}

variable "backend_bucket" {
  type        = string
  description = "The S3 bucket for backend state storage."
}

variable "node_groups_test_tt" {
  description = "List of node groups with specific ingress and egress rules"
  type = list(object({
    name            = string
    instance_types  = list(string)
    ng_test_tags = map(string)
    labels          = map(string)
    minimum_size    = number
    maximum_size    = number
    desired_size    = number
    capacity_type   = string

  }))
}
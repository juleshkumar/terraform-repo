variable "k8s_version" {
  description = "Kubernetes version."
  type        = string
}

variable "cluster-name" {
  description = "The name of the cluster"
  type        = string
}

variable "cloudwatch_logs" {
  type        = bool
  description = "Setup full Cloudwatch logging."
}

variable "cluster-autoscaler" {
  type        = bool
  description = "Install k8s Cluster Autoscaler."
}

variable "eks_tags" {
  type = map(string)
}

variable "region" {
  type = string
}

 variable "backend_path" {
  description = "The name of the cluster"
  type        = string
}

variable "backend_bucket" {
  type = string
}

#variable "role_arn" {
#  type = string
#  description = "aws iam role"
#}
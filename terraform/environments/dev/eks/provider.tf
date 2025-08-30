terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.43.0"
    }
  }
}

provider "aws" {
  region = "ap-south-1"
  
  #assume_role {
  #  role_arn = var.role_arn
  #  # Optionally, you can add other parameters such as session_name, external_id, etc.
  #  # session_name = "example-session"
  #}


}

provider "kubernetes" {
  #  version = "~> 2.0"

  // Kubernetes cluster configuration
  host = module.eks.eks_cluster_endpoint
}

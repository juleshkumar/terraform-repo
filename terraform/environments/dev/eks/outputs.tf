#eks
output "eks_cluster_id" {
  description = "The name of the cluster"
  #  value       = join("", aws_eks_cluster.eks.*.id)
  value = module.eks.eks_cluster_id
}

output "eks_cluster_arn" {
  description = "The Amazon Resource Name (ARN) of the cluster"
  #  value       = join("", aws_eks_cluster.eks.*.arn)
  value = module.eks.eks_cluster_arn
}

output "eks_cluster_certificate_authority" {
  description = "The Amazon Resource Name (ARN) of the cluster"
  #  value       = join("", aws_eks_cluster.eks.*.arn)
  value = module.eks.eks_cluster_certificate_authority
}

output "eks_cluster_endpoint" {
  description = "The endpoint for the Kubernetes API server"
  #  value       = join("", aws_eks_cluster.eks.*.endpoint)
  value = module.eks.eks_cluster_endpoint
}

output "eks_cluster_version" {
  description = "The Kubernetes server version of the cluster"
  #  value       = join("", aws_eks_cluster.eks.*.version)
  value = module.eks.eks_cluster_version
}

output "eks_allow_vpc_cidr_sg_id" {
  description = "The ID of the EKS Allow VPC CIDR Security Group"
  value       = module.eks.eks_allow_vpc_cidr_sg_id
}

output "eks_cluster_sg_id" {
  description = "The ID of the EKS Cluster Security Group"
  value       = module.eks.eks_cluster_sg_id
}

output "eks_allow_vpc_cidr_sg_arn" {
  description = "The ARN of the EKS Allow VPC CIDR Security Group"
  value       = module.eks.eks_allow_vpc_cidr_sg_arn
}

output "eks_cluster_sg_arn" {
  description = "The ARN of the EKS Cluster Security Group"
  value       = module.eks.eks_cluster_sg_arn
}




#eks
output "eks_cluster_id" {
  description = "The name of the cluster"
  value       = join("", aws_eks_cluster.eks.*.id)
}

output "eks_cluster_arn" {
  description = "The Amazon Resource Name (ARN) of the cluster"
  value       = join("", aws_eks_cluster.eks.*.arn)
}

output "eks_cluster_endpoint" {
  description = "The endpoint for the Kubernetes API server"
  value       = join("", aws_eks_cluster.eks.*.endpoint)
}

output "eks_cluster_certificate_authority" {
  description = "The certificate-authority-data for the EKS cluster"
  value       = (join("", aws_eks_cluster.eks[*].certificate_authority[0].data))
}


output "eks_cluster_version" {
  description = "The Kubernetes server version of the cluster"
  value       = join("", aws_eks_cluster.eks.*.version)
}

output "eks_allow_vpc_cidr_sg_id" {
  description = "The ID of the EKS Allow VPC CIDR Security Group"
  value       = aws_security_group.eks_allow_vpc_cidr.id
}

output "eks_cluster_sg_id" {
  description = "The ID of the EKS Cluster Security Group"
  value       = aws_security_group.eks_cluster_sg.id
}

output "eks_allow_vpc_cidr_sg_arn" {
  description = "The ARN of the EKS Allow VPC CIDR Security Group"
  value       = aws_security_group.eks_allow_vpc_cidr.arn
}

output "eks_cluster_sg_arn" {
  description = "The ARN of the EKS Cluster Security Group"
  value       = aws_security_group.eks_cluster_sg.arn
}






output "eks_node_role_arn" {
  description = "The ARN of the EKS node role"
  value       = module.nodegroup.eks_node_role_arn
}
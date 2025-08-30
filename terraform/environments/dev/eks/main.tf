module "eks" {
  source                         = "../../../modules/eks"
  cloudwatch_logs                = var.cloudwatch_logs
  cluster-autoscaler             = var.cluster-autoscaler
  cluster-name                   = var.cluster-name
  k8s_version                    = var.k8s_version
  eks_tags                       = var.eks_tags
  region                         = var.region
  backend_bucket                 = var.backend_bucket
  backend_path                   = var.backend_path
  #role_arn           = var.role_arn
}

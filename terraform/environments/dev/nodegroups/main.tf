module "nodegroup" {
  source                           = "../../../modules/nodegroup"
  cloudwatch_logs                  = var.cloudwatch_logs
  cluster-name                     = var.cluster-name
  customer_name                    = var.customer_name
  ec2_root_volume_size             = var.ec2_root_volume_size
  nodegroup_name                   = var.nodegroup_name
  environment                      = var.environment
  region                           = var.region
  backend_bucket                   = var.backend_bucket
  service_cidr                     = var.service_cidr
  node_groups_test_tt              = var.node_groups_test_tt
  backend_path                     = var.backend_path
  #role_arn                        = var.role_arn

}
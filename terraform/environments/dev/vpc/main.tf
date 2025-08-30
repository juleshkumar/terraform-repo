module "vpc" {
  source                     = "../../../modules/vpc"
  vpc_cidr                   = var.vpc_cidr
  public_subnet_1_cidr       = var.public_subnet_1_cidr
  public_subnet_2_cidr       = var.public_subnet_2_cidr
  public_subnet_3_cidr       = var.public_subnet_3_cidr
  private_subnet_1_cidr      = var.private_subnet_1_cidr
  private_subnet_2_cidr      = var.private_subnet_2_cidr
  private_subnet_3_cidr      = var.private_subnet_3_cidr
  vpc_tags                   = var.vpc_tags
  cluster-name               = var.cluster-name
  environment                = var.environment
  customer_name              = var.customer_name
}

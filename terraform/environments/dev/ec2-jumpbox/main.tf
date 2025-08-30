

module "jumpbox" {
  source            = "../../../modules/ec2-jumpbox"
  ami               = var.ami
  ec2_instance_type = var.ec2_instance_type
  customer_name      = var.customer_name
  js_user           = var.js_user
  jumpbox_tags = var.jumpbox_tags
  backend_bucket     = var.backend_bucket
  region             = var.region
  backend_path       = var.backend_path
  environment        = var.environment
  #role_arn           = var.role_arn
}

module "elasticsearch" {
  source            = "../../../modules/ec2-redis"
  elasticsearch_ami               = var.elasticsearch_ami
  elasticsearch_ec2_instance_type = var.elasticsearch_ec2_instance_type
  customer_name      = var.customer_name
  elasticsearch_user           = var.elasticsearch_user
  elasticsearch_tags = var.elasticsearch_tags
  backend_bucket     = var.backend_bucket
  region             = var.region
  backend_path       = var.backend_path
  environment        = var.environment
  #role_arn           = var.role_arn
}
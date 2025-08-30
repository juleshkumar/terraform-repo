module "postgres" {
  source                     = "../../../modules/rds"
  major_version              = var.major_version
  engine_version             = var.engine_version
  gyan_bharatam_database_name          = var.gyan_bharatam_database_name
  gyan_bharatam_db_allocated_storage   = var.gyan_bharatam_db_allocated_storage
  gyan_bharatam_db_instance_identifier = var.gyan_bharatam_db_instance_identifier
  gyan_bharatam_db_instance_type       = var.gyan_bharatam_db_instance_type
  gyan_bharatam_db_security_group      = var.gyan_bharatam_db_security_group
  rds_secret_name          = var.rds_secret_name
  rds_multi_az               = var.rds_multi_az
  rds_tags = var.rds_tags
  rds_port                   = var.rds_port
  backend_bucket     = var.backend_bucket
  region             = var.region
  backend_path       = var.backend_path
}

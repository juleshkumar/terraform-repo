output "rds_endpoint" {
  value = module.postgres.rds_endpoint
}

output "rds_security_group_id" {
  value = module.postgres.rds_security_group_id
}

output "rds_subnet_group_name" {
  value = module.postgres.rds_subnet_group_name
}

output "rds_parameter_group_name" {
  value = module.postgres.rds_parameter_group_name
}

output "rds_database_identifier" {
  value = module.postgres.rds_database_identifier
}

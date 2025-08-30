output "rds_endpoint" {
  value = aws_db_instance.gyan_bharatam_database_instance.endpoint
}

output "rds_security_group_id" {
  value = aws_security_group.rds_security.id
}

output "rds_subnet_group_name" {
  value = aws_db_subnet_group.gyan_bharatam_subnet_group.name
}

output "rds_parameter_group_name" {
  value = aws_db_parameter_group.gyan_bharatam_database.name
}

output "rds_database_identifier" {
  value = aws_db_instance.gyan_bharatam_database_instance.identifier
}

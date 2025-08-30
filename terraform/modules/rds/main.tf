data "terraform_remote_state" "vpc_state" {
  backend = "s3"

  config = {
    bucket     = var.backend_bucket
    key        = "${var.backend_path}/backend/vpc"
    region     = var.region
    #role_arn   = var.role_arn
  }
}

data "terraform_remote_state" "kms" {
  backend = "s3"

  config = {
    bucket     = var.backend_bucket
    key        = "${var.backend_path}/backend/kms"
    region     = var.region
    #role_arn   = var.role_arn
  }
}

# Retrieve the secret from AWS Secrets Manager
data "aws_secretsmanager_secret" "rds" {
  name = "${var.rds_secret_name}/credentials"
}

# Retrieve the secret version (actual values)
data "aws_secretsmanager_secret_version" "rds_value" {
  secret_id = data.aws_secretsmanager_secret.rds.id
}

# Parse the secret string as JSON
locals {
  creds = jsondecode(data.aws_secretsmanager_secret_version.rds_value.secret_string)
}

resource "aws_db_subnet_group" "gyan_bharatam_subnet_group" {
  name        = "${var.gyan_bharatam_db_instance_identifier}-subnet-group"
  description = "gyan_bharatam RDS subnet group"
  subnet_ids  = data.terraform_remote_state.vpc_state.outputs.private_subnet_ids
}

resource "aws_security_group" "rds_security" {
  name        = var.gyan_bharatam_db_security_group
  description = "gyan_bharatam RDS PostgreSQL server"
  vpc_id      = data.terraform_remote_state.vpc_state.outputs.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "${var.gyan_bharatam_db_security_group}"
  }
}


// PgSQL can only be accessed from the WWW network (10.0.0.0/8)
resource "aws_security_group_rule" "gyan_bharatam_ingress_rules" {
  type              = "ingress"
  from_port         = var.rds_port
  to_port           = var.rds_port
  protocol          = "tcp"
  cidr_blocks       = [data.terraform_remote_state.vpc_state.outputs.vpc_cidr_block]
  security_group_id = aws_security_group.rds_security.id
}



resource "aws_db_parameter_group" "gyan_bharatam_database" {
  name        = "${var.gyan_bharatam_db_instance_identifier}-param-group"
  description = "gyan_bharatam parameter group for postgreSQL"
  family      = "postgres${var.major_version}"
  parameter {
    apply_method = "pending-reboot"
    name         = "max_connections"
    value        = "3000"
  }
}

resource "aws_db_instance" "gyan_bharatam_database_instance" {
  identifier                = var.gyan_bharatam_db_instance_identifier
  allocated_storage         = var.gyan_bharatam_db_allocated_storage
  engine                    = "postgres"
  engine_version            = var.engine_version
  instance_class            = var.gyan_bharatam_db_instance_type
  db_name                   = var.gyan_bharatam_database_name
  username                  = local.creds.psql_username
  password                  = local.creds.psql_password
  db_subnet_group_name      = aws_db_subnet_group.gyan_bharatam_subnet_group.name
  storage_encrypted         = true
  multi_az                  = var.rds_multi_az
  vpc_security_group_ids    = [aws_security_group.rds_security.id]
  storage_type              = "gp3"
  skip_final_snapshot       = true
  final_snapshot_identifier = "Ignore"
  parameter_group_name      = aws_db_parameter_group.gyan_bharatam_database.name
  apply_immediately         = true
  port                      = var.rds_port
  backup_retention_period   = 7  # Recommended to keep backups even with extended support off
  backup_window             = "03:00-04:00"  # Default backup window
  maintenance_window        = "sun:04:00-sun:05:00"  # Default maintenance window
  copy_tags_to_snapshot     = true
  publicly_accessible       = false
  kms_key_id = data.terraform_remote_state.kms.outputs.key_arn
  deletion_protection           = true                 
  performance_insights_enabled  = true
  auto_minor_version_upgrade = false


  tags = var.rds_tags
}

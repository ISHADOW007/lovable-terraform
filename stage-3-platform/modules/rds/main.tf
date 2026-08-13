############################################################
# PostgreSQL RDS Instance
############################################################

resource "aws_db_instance" "this" {

  ##########################################################
  # General
  ##########################################################

  identifier = var.name

  engine = "postgres"

  engine_version = "16.14" 

  instance_class = var.instance_class

  allocated_storage = var.allocated_storage

  storage_type = "gp2"

  storage_encrypted = true

  ##########################################################
  # Database
  ##########################################################

  db_name = var.database_name

  username = var.username

  password = var.password

  port = 5432

  ##########################################################
  # Network
  ##########################################################

  db_subnet_group_name = aws_db_subnet_group.this.name

  vpc_security_group_ids = [

    aws_security_group.this.id

  ]

  publicly_accessible = false

  multi_az = var.multi_az

  ##########################################################
  # Backup
  ##########################################################

  backup_retention_period = 0

  backup_window = "03:00-04:00"

  maintenance_window = "Sun:04:00-Sun:05:00"

  ##########################################################
  # Monitoring
  ##########################################################

  monitoring_interval = 0

  performance_insights_enabled = false

  enabled_cloudwatch_logs_exports = [

    "postgresql"

  ]

  ##########################################################
  # Protection
  ##########################################################

  deletion_protection = false

  skip_final_snapshot = true

  apply_immediately = true

  ##########################################################
  # Tags
  ##########################################################

  tags = {

    Name = var.name

    Terraform = "true"

  }

}
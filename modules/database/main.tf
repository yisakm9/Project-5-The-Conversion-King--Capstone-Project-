# modules/database/main.tf
# This  data source looks up the latest available version for the given engine and major version
data "aws_rds_engine_version" "postgres" {
  engine  = var.db_engine
  version = var.db_major_engine_version # e.g., "14.19"
}


resource "random_password" "master" {
  length  = 16
  special = true
  # Do not include characters that must be escaped in shell scripts
  override_special = "!#%&()*+,-./:;<=>?@[]^_`{|}~"
}
resource "aws_secretsmanager_secret" "rds_credentials" {
  name = "${var.project_name}-a${var.environment}/rds-master-credentials"
  tags = {
    Project     = var.project_name
    Environment = var.environment
  }
}
resource "aws_secretsmanager_secret_version" "rds_credentials" {
  secret_id = aws_secretsmanager_secret.rds_credentials.id
  secret_string = jsonencode({
    username = var.db_username
    password = random_password.master.result
  })
}
resource "aws_db_subnet_group" "main" {
  name       = "${var.project_name}-subnet-group-${var.environment}"
  subnet_ids = var.private_subnet_ids

  tags = {
    Name = "${var.project_name}-subnet-group-${var.environment}"
  }
}
resource "aws_db_instance" "main" {
  identifier             = "${var.project_name}-db-${var.environment}"
  engine                 = var.db_engine
  engine_version         = data.aws_rds_engine_version.postgres.version # <-- Use the version from the data source
  instance_class         = var.db_instance_class
  allocated_storage      = var.db_allocated_storage
  storage_type           = "gp2"
  username               = jsondecode(aws_secretsmanager_secret_version.rds_credentials.secret_string)["username"]
  password               = jsondecode(aws_secretsmanager_secret_version.rds_credentials.secret_string)["password"]
  db_subnet_group_name   = aws_db_subnet_group.main.name
  vpc_security_group_ids = [var.rds_security_group_id]
  publicly_accessible    = false
  skip_final_snapshot    = var.skip_final_snapshot # Set to false in production
  tags = {
    Name = "${var.project_name}-db-${var.environment}"
  }
}
# modules/database/outputs.tf

output "db_instance_endpoint" {
  description = "The connection endpoint for the database instance."
  value       = aws_db_instance.main.endpoint
}

output "db_instance_port" {
  description = "The port for the database instance."
  value       = aws_db_instance.main.port
}

output "db_credentials_secret_arn" {
  description = "The ARN of the AWS Secrets Manager secret for DB credentials."
  value       = aws_secretsmanager_secret.rds_credentials.arn
}
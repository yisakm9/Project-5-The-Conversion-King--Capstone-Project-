# environments/dev/outputs.tf

output "database_endpoint" {
  description = "The connection endpoint for the RDS database instance."
  value       = module.database.db_instance_endpoint
}

output "database_credentials_secret_arn" {
  description = "The ARN of the secret containing the master database credentials."
  value       = module.database.db_credentials_secret_arn
}

output "redis_primary_endpoint" {
  description = "The primary connection endpoint for the ElastiCache for Redis cluster."
  value       = module.elasticache.primary_endpoint_address
}

output "vpc_id" {
  description = "The ID of the deployed VPC."
  value       = module.vpc.vpc_id
}


# environments/dev/outputs.tf

output "database_endpoint" {
  description = "The connection endpoint for the RDS database instance."
  value       = module.database.db_instance_endpoint
}

# ... (other outputs) ...

# UNCOMMENT THIS OUTPUT
output "application_url" {
  description = "The public URL of the Application Load Balancer."
  value       = "http://${module.alb.alb_dns_name}"
}
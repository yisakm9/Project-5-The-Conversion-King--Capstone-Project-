# modules/elasticache/outputs.tf

output "primary_endpoint_address" {
  description = "The connection endpoint for the primary Redis node."
  value       = aws_elasticache_replication_group.main.primary_endpoint_address
}

output "port" {
  description = "The port for the Redis cluster."
  value       = aws_elasticache_replication_group.main.port
}
# modules/elasticache/main.tf

resource "aws_elasticache_subnet_group" "main" {
  name       = "${var.project_name}-cache-subnet-group-${var.environment}"
  subnet_ids = var.private_subnet_ids

  tags = {
    Name = "${var.project_name}-cache-subnet-group"
  }
}

resource "aws_elasticache_replication_group" "main" {
  replication_group_id          = "${var.project_name}-redis-${var.environment}"
  description                   = "Redis cluster for the Conversion King application"
  node_type                     = var.node_type
  engine                        = "redis"
  engine_version                = var.engine_version
  port                          = 6379
  automatic_failover_enabled    = true # Critical for high availability
  num_cache_clusters            = 2    # Creates a primary and one replica for failover
  subnet_group_name             = aws_elasticache_subnet_group.main.name
  security_group_ids            = [var.elasticache_security_group_id]
  transit_encryption_enabled    = true
  at_rest_encryption_enabled    = true

  tags = {
    Name = "${var.project_name}-redis-cluster-${var.environment}"
  }
}
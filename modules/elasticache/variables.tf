# modules/elasticache/variables.tf

variable "project_name" {
  description = "The name of the project."
  type        = string
}

variable "environment" {
  description = "The deployment environment."
  type        = string
}

variable "private_subnet_ids" {
  description = "List of private subnet IDs for the ElastiCache cluster."
  type        = list(string)
}

variable "elasticache_security_group_id" {
  description = "The ID of the security group for ElastiCache."
  type        = string
}

variable "node_type" {
  description = "The instance type for the Redis nodes."
  type        = string
  default     = "cache.t3.micro"
}

variable "engine_version" {
  description = "The Redis engine version."
  type        = string
  default     = "7.0"
}
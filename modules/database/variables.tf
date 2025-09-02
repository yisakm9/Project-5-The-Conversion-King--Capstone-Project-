# modules/database/variables.tf

variable "project_name" {
  description = "The name of the project."
  type        = string
}

variable "environment" {
  description = "The deployment environment."
  type        = string
}

variable "private_subnet_ids" {
  description = "A list of private subnet IDs for the DB subnet group."
  type        = list(string)
}

variable "rds_security_group_id" {
  description = "The ID of the security group for the RDS instance."
  type        = string
}

variable "db_instance_class" {
  description = "The instance class for the RDS instance."
  type        = string
  default     = "db.t3.micro"
}

variable "db_engine" {
  description = "The database engine."
  type        = string
  default     = "postgres"
}

variable "db_engine_version" {
  description = "The database engine version."
  type        = string
  default     = "14.6"
}

variable "db_allocated_storage" {
  description = "The allocated storage in GB."
  type        = number
  default     = 20
}

variable "db_username" {
  description = "The master username for the database."
  type        = string
  default     = "masteruser"
}
# environments/dev/variables.tf

variable "aws_region" {
  description = "The AWS region where resources will be created."
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "The name of the project."
  type        = string
  default     = "conversion-king"
}

variable "environment" {
  description = "The deployment environment (e.g., dev, stg, prod)."
  type        = string
  default     = "dev"
}

variable "instance_type_dev" {
  description = "The EC2 instance type to use for the dev environment."
  type        = string
  default     = "t3.micro"
}

variable "db_instance_class_dev" {
  description = "The RDS instance class to use for the dev environment."
  type        = string
  default     = "db.t3.micro"
}

variable "db_allocated_storage" {
  description = "The allocated storage in GB."
  type        = number
  default     = 20
}


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
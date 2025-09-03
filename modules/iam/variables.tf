variable "project_name" {
  description = "The name of the project."
  type        = string
}

variable "environment" {
  description = "The deployment environment."
  type        = string
}

variable "db_credentials_secret_arn" {
  description = "The ARN of the Secrets Manager secret containing the RDS database credentials."
  type        = string
}


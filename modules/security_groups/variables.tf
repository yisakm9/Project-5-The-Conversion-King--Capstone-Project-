# modules/security_groups/variables.tf

variable "project_name" {
  description = "The name of the project."
  type        = string
}

variable "environment" {
  description = "The deployment environment."
  type        = string
}

variable "vpc_id" {
  description = "The ID of the VPC where security groups will be created."
  type        = string
}

variable "app_port" {
  description = "The port the application listens on."
  type        = number
  default     = 8080
}
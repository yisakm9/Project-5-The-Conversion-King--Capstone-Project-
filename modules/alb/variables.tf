# modules/alb/variables.tf

variable "project_name" {
  description = "The name of the project."
  type        = string
}

variable "environment" {
  description = "The deployment environment."
  type        = string
}

variable "vpc_id" {
  description = "The ID of the VPC."
  type        = string
}

variable "public_subnet_ids" {
  description = "A list of public subnet IDs for the ALB."
  type        = list(string)
}

variable "alb_security_group_id" {
  description = "The ID of the security group for the ALB."
  type        = string
}

variable "app_port" {
  description = "The port the application listens on (for the target group)."
  type        = number
  default     = 8080
}

variable "autoscaling_group_name" {
  description = "The name of the Auto Scaling Group to attach to the ALB."
  type        = string
}
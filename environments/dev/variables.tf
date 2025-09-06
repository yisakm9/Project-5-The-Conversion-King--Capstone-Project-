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

variable "db_skip_final_snapshot" {
  description = "Set to true to allow easy destruction of the dev database without a snapshot."
  type        = bool
  default     = false
}

variable "min_size" {
  description = "The minimum number of instances in the Auto Scaling Group."
  type        = number
  default     = 1
}

variable "max_size" {
  description = "The maximum number of instances in the Auto Scaling Group."
  type        = number
  default     = 3
}

variable "desired_capacity" {
  description = "The desired number of instances in the Auto Scaling Group."
  type        = number
  default     = 1
}
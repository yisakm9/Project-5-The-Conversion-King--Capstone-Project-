# modules/autoscaling/variables.tf

variable "project_name" {
  description = "The name of the project."
  type        = string
}

variable "environment" {
  description = "The deployment environment (e.g., dev, stg, prod)."
  type        = string
}

variable "private_subnet_ids" {
  description = "A list of private subnet IDs where the EC2 instances will be launched."
  type        = list(string)
}

variable "ec2_security_group_id" {
  description = "The ID of the security group to associate with the EC2 instances."
  type        = string
}

variable "instance_profile_name" {
  description = "The name of the IAM instance profile to attach to the EC2 instances."
  type        = string
}

variable "instance_type" {
  description = "The EC2 instance type for the application servers."
  type        = string
  default     = "t3.micro"
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
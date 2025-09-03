# modules/autoscaling/outputs.tf

output "autoscaling_group_name" {
  description = "The name of the Auto Scaling Group."
  value       = aws_autoscaling_group.main.name
}

output "autoscaling_group_arn" {
  description = "The ARN of the Auto Scaling Group."
  value       = aws_autoscaling_group.main.arn
}

output "launch_template_id" {
  description = "The ID of the Launch Template."
  value       = aws_launch_template.main.id
}

output "launch_template_latest_version" {
  description = "The latest version number of the Launch Template."
  value       = aws_launch_template.main.latest_version
}
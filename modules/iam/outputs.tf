# modules/iam/outputs.tf
output "instance_profile_name" {
  description = "The name of the EC2 instance profile."
  value       = aws_iam_instance_profile.ec2_profile.name
}
output "role_name" {
  description = "The name of the IAM role."
  value       = aws_iam_role.ec2_role.name
}
output "secrets_manager_policy_arn" {
  description = "The ARN of the Secrets Manager read policy."
  value       = aws_iam_policy.secrets_manager_read.arn
}

output "bedrock_policy_arn" {
  description = "The ARN of the Bedrock invoke policy."
  value       = aws_iam_policy.bedrock_invoke.arn
}

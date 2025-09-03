# modules/iam/main.tf

# IAM Role that EC2 instances will assume
resource "aws_iam_role" "ec2_role" {
  name = "${var.project_name}-ec2-role-${var.environment}"
  path = "/"

  assume_role_policy = jsonencode({
    Version   = "2012-10-17",
    Statement = [
      {
        Action    = "sts:AssumeRole",
        Effect    = "Allow",
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

# IAM Policy to allow reading the RDS secret
resource "aws_iam_policy" "secrets_manager_read" {
  name        = "${var.project_name}-secrets-manager-read-policy-${var.environment}"
  description = "Allows reading the specific RDS secret"
  policy = jsonencode({
    Version   = "2012-10-17",
    Statement = [
      {
        Action   = "secretsmanager:GetSecretValue",
        Effect   = "Allow",
        Resource = var.db_credentials_secret_arn
      }
    ]
  })
}

# IAM Policy to allow invoking the Bedrock model
resource "aws_iam_policy" "bedrock_invoke" {
  name        = "${var.project_name}-bedrock-invoke-policy-${var.environment}"
  description = "Allows invoking Bedrock models for recommendations"
  policy = jsonencode({
    Version   = "2012-10-17",
    Statement = [
      {
        Action   = "bedrock:InvokeModel",
        Effect   = "Allow",
        Resource = "*" # For production, scope this down to specific model ARNs
      }
    ]
  })
}

# Attach the policies to the role
resource "aws_iam_role_policy_attachment" "secrets_manager" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = aws_iam_policy.secrets_manager_read.arn
}

resource "aws_iam_role_policy_attachment" "bedrock" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = aws_iam_policy.bedrock_invoke.arn
}

# Instance Profile that links the IAM Role to EC2
resource "aws_iam_instance_profile" "ec2_profile" {
  name = "${var.project_name}-ec2-profile-${var.environment}"
  role = aws_iam_role.ec2_role.name
}
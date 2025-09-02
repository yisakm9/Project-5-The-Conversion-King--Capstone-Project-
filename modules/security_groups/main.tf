# modules/security_groups/main.tf

# 1. Security Group for the Application Load Balancer (ALB)
resource "aws_security_group" "alb" {
  name        = "${var.project_name}-alb-sg-${var.environment}"
  description = "Controls access to the ALB"
  vpc_id      = var.vpc_id

  # Ingress: Allow HTTP and HTTPS traffic from the internet
  ingress {
    protocol    = "tcp"
    from_port   = 80
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    protocol    = "tcp"
    from_port   = 443
    to_port     = 443
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Egress: Allow all outbound traffic
  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-alb-sg-${var.environment}"
  }
}

# 2. Security Group for the EC2 Instances (Application Layer)
resource "aws_security_group" "ec2" {
  name        = "${var.project_name}-ec2-sg-${var.environment}"
  description = "Controls access to the EC2 instances"
  vpc_id      = var.vpc_id

  # Ingress: Allow traffic ONLY from the ALB on the application port
  ingress {
    protocol        = "tcp"
    from_port       = var.app_port
    to_port         = var.app_port
    security_groups = [aws_security_group.alb.id]
  }

  # Egress: Allow all outbound traffic to the internet (for AWS API calls, etc.)
  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-ec2-sg-${var.environment}"
  }
}

# 3. Security Group for the RDS Database
resource "aws_security_group" "rds" {
  name        = "${var.project_name}-rds-sg-${var.environment}"
  description = "Controls access to the RDS database"
  vpc_id      = var.vpc_id

  # Ingress: Allow traffic ONLY from the EC2 instances on the Postgres port
  ingress {
    protocol        = "tcp"
    from_port       = 5432 # Standard PostgreSQL port
    to_port         = 5432
    security_groups = [aws_security_group.ec2.id]
  }

  # Egress: (Optional but good practice) Deny all outbound traffic
  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["127.0.0.1/32"] # A trick to block all traffic
  }

  tags = {
    Name = "${var.project_name}-rds-sg-${var.environment}"
  }
}

# 4. Security Group for the ElastiCache Cluster
resource "aws_security_group" "elasticache" {
  name        = "${var.project_name}-elasticache-sg-${var.environment}"
  description = "Controls access to the ElastiCache cluster"
  vpc_id      = var.vpc_id

  # Ingress: Allow traffic ONLY from the EC2 instances on the Redis port
  ingress {
    protocol        = "tcp"
    from_port       = 6379 # Standard Redis port
    to_port         = 6379
    security_groups = [aws_security_group.ec2.id]
  }

  tags = {
    Name = "${var.project_name}-elasticache-sg-${var.environment}"
  }
}
# modules/autoscaling/main.tf

# Data source to find the latest Amazon Linux 2023 AMI automatically
data "aws_ami" "amazon_linux_2023" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-kernel-6.1-x86_64"]
  }
}

resource "aws_launch_template" "main" {
  name_prefix   = "${var.project_name}-${var.environment}-"
  image_id      = data.aws_ami.amazon_linux_2023.id
  instance_type = var.instance_type

  iam_instance_profile {
    name = var.instance_profile_name
  }

  vpc_security_group_ids = [var.ec2_security_group_id]

  # User data script to bootstrap the instance (install app, etc.)
  # For now, we'll just install a simple web server for health checks.
  user_data = base64encode(<<-EOF
              #!/bin/bash
              yum update -y
              yum install -y httpd
              systemctl start httpd
              systemctl enable httpd
              echo "<h1>Hello from Conversion King Instance</h1>" > /var/www/html/index.html
              EOF
  )

  tags = {
    Name = "${var.project_name}-launch-template"
  }
}

resource "aws_autoscaling_group" "main" {
  name_prefix = "${var.project_name}-asg-${var.environment}-"
  
  launch_template {
    id      = aws_launch_template.main.id
    version = "$Latest"
  }

  min_size            = var.min_size
  max_size            = var.max_size
  desired_capacity    = var.desired_capacity
  vpc_zone_identifier = var.private_subnet_ids
  
  # The ALB will perform health checks. If an instance fails, the ASG will replace it.
  health_check_type         = "ELB"
  health_check_grace_period = 300

  tag {
    key                 = "Name"
    value               = "${var.project_name}-instance-${var.environment}"
    propagate_at_launch = true
  }
}
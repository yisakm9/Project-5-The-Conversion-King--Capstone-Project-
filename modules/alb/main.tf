# modules/alb/main.tf

# 1. The Application Load Balancer resource
resource "aws_lb" "main" {
  name               = "${var.project_name}-alb-${var.environment}"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.alb_security_group_id]
  subnets            = var.public_subnet_ids

  enable_deletion_protection = false # Set to true in production

  tags = {
    Name        = "${var.project_name}-alb-${var.environment}"
    Environment = var.environment
  }
}

# 2. The Target Group for our application instances
resource "aws_lb_target_group" "app" {
  name        = "${var.project_name}-tg-${var.environment}"
  port        = var.app_port
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "instance"

  health_check {
    enabled             = true
    path                = "/" # The path ALB will check for a 200 OK response
    protocol            = "HTTP"
    matcher             = "200"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }

  tags = {
    Name = "${var.project_name}-tg-${var.environment}"
  }
}

# 3. The Listener for incoming web traffic (HTTP on port 80)
resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.main.arn
  port              = "80"
  protocol          = "HTTP"

  /*
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app.arn
  }
  */

  # Add a temporary fixed response action used to break dependencies during port fix
  
  default_action {
    type = "fixed-response"
    fixed_response {
      content_type = "text/plain"
      message_body = "Under Maintenance"
      status_code  = "503"
    }
  }
  
}

# 4. Crucial Step: Attach the Auto Scaling Group to the Target Group
resource "aws_autoscaling_attachment" "main" {
  autoscaling_group_name = var.autoscaling_group_name
  lb_target_group_arn    = aws_lb_target_group.app.arn
}
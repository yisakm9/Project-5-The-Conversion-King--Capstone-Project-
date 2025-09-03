# modules/alb/outputs.tf

output "alb_dns_name" {
  description = "The public DNS name of the Application Load Balancer."
  value       = aws_lb.main.dns_name
}

output "alb_zone_id" {
  description = "The zone ID of the Application Load Balancer (for Route 53 aliases)."
  value       = aws_lb.main.zone_id
}
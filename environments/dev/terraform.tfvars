# environments/dev/terraform.tfvars

aws_region   = "us-east-1"
project_name = "conversion-king"
environment  = "dev"
db_skip_final_snapshot = true     # Seted to true for dev environment



# You can override the default values from variables.tf here if needed.
# For example, to use a different instance size for a specific test:
# instance_type_dev = "t3.small"
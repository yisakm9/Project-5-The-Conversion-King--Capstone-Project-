#  environments/dev/main.tf

module "vpc" {
  source = "../../modules/vpc"

  project_name         = var.project_name
  environment          = var.environment
  availability_zones   = ["us-east-1a", "us-east-1b"]
  public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnet_cidrs = ["10.0.101.0/24", "10.0.102.0/24"]
}

module "security_groups" {
  source = "../../modules/security_groups"

  project_name = var.project_name
  environment  = var.environment
  vpc_id       = module.vpc.vpc_id
  # We can accept the default app_port of 8080
}

module "database" {
  source = "../../modules/database"

  project_name          = var.project_name
  environment           = var.environment
  private_subnet_ids    = module.vpc.private_subnet_ids
  rds_security_group_id = module.security_groups.rds_security_group_id
  skip_final_snapshot = var.db_skip_final_snapshot
  # For dev, we can use smaller, cheaper instance types
  db_instance_class    = var.db_instance_class_dev
  db_allocated_storage = var.db_allocated_storage
}

module "elasticache" {
  source = "../../modules/elasticache"

  project_name                  = var.project_name
  environment                   = var.environment
  private_subnet_ids            = module.vpc.private_subnet_ids
  elasticache_security_group_id = module.security_groups.elasticache_security_group_id
}
module "iam" {
  source = "../../modules/iam"

  project_name              = var.project_name
  environment               = var.environment
  db_credentials_secret_arn = module.database.db_credentials_secret_arn
}

module "autoscaling" {
  source = "../../modules/autoscaling"

  project_name          = var.project_name
  environment           = var.environment
  private_subnet_ids    = module.vpc.private_subnet_ids
  ec2_security_group_id = module.security_groups.ec2_security_group_id
  instance_profile_name = module.iam.instance_profile_name

  # Use the environment-specific variable
  instance_type    = var.instance_type_dev
  min_size         = var.min_size
  max_size         = var.max_size
  desired_capacity = var.desired_capacity
}

module "alb" {
  source = "../../modules/alb"

  project_name           = var.project_name
  environment            = var.environment
  vpc_id                 = module.vpc.vpc_id
  public_subnet_ids      = module.vpc.public_subnet_ids
  alb_security_group_id  = module.security_groups.alb_security_group_id
  autoscaling_group_name = module.autoscaling.autoscaling_group_name

  # The app_port defaults to 8080, which matches our SG module, so we don't need to set it.
}
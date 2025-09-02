# environments/dev/provider.tf
provider "aws" {
  region = var.aws_region
}
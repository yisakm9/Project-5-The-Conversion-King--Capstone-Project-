terraform {
  backend "s3" {
    bucket       = "ysak-terraform-state-bucket"
    key          = "terraform.tfstate"
    region       = "us-east-1"
    encrypt      = true
    use_lockfile = true
  }
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 6.0" # Use a recent version of the AWS provider
    }
  }
}

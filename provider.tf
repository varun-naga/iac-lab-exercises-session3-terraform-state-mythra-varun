terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>6.0"
    }
  }

}

provider "aws" {
  region = var.region
  default_tags {
    tags = {
      ManagedBy   = "Terraform"
      Project     = var.prefix
      Environment = "Dev"
    }
  }
}
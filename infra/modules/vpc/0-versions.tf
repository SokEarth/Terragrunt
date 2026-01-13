terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">=5.95.0, < 7.0.0"
    }
  }

  required_version = "~> 1.13.1"
}
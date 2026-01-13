terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">=5.95.0, < 7.0.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.13"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.25"
    }
  }

  required_version = "~> 1.13.1"
}
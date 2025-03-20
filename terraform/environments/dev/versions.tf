provider "aws" {
  region = var.aws_region
  default_tags {
    tags = {
      Environment = "dev"
      Creator = "Andrei Lesi"
      Workshop = "ServerlessSaaSWS"
    }
  }
}

terraform {
  required_version = ">= 1.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.9"
    }
  }
}


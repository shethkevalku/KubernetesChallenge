terraform {
  required_version = ">=0.13.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      #version = "~> 4.0"
      version = "5.6.2"
    }
  }
}



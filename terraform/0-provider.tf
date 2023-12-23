provider "aws" {
  region = "us-west-1"
  shared_credentials_file = "/home/ec2-user/.aws/credentials"
  profile = "ik_demo"
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

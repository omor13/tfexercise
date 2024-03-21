terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  backend "s3" {
    bucket = "fadi-tf-states-new"
    key = "states/project.tfstate"
    region = "us-east-1"
  }
}

provider "aws" {
  region = "us-east-1"
}


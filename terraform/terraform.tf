terraform {
  backend "s3" {
    bucket  = "terraform-remote-state-qd"
    key     = "terraform.tfstate"
    region  = "us-west-2"
    profile = "qd-dev"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.29.0"
    }
  }
}

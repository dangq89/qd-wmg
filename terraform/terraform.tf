terraform {
  backend "s3" {
    bucket  = "<terraform_remote_state_bucket>"
    key     = "terraform.tfstate"
    region  = "<aws_region>"
    profile = "<aws_profile>"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.29.0"
    }
  }
}

# AWS Profile
aws_region     = "us-west-2"
aws_profile    = "qd-dev"
name           = "watchmaker"
aws_account_id = "881700076394"

# ECR
ecr_image_tag    = "latest"
image_mutability = "MUTABLE"

# Lambda
architecture = ["arm64"]
publish      = "false"

# S3
versioning        = true
long_term_storage = true
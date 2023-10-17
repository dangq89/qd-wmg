# AWS Profile
aws_region     = "<aws_region>"
aws_profile    = "<aws_profile>"
aws_account_id = "<aws_account_id>"

name           = "watchmaker"

# ECR
ecr_image_tag    = "latest"
image_mutability = "MUTABLE"

# Lambda
architecture = ["arm64"]
publish      = "false"

# S3
versioning        = true
long_term_storage = true
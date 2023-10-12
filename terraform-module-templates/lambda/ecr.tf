# Main ECR Resources
data "aws_ecr_repository" "this" {
  name     = var.ecr_repo_name
}

data "aws_ecr_image" "this" {
  repository_name = data.aws_ecr_repository.this.name
  image_tag       = var.ecr_image_tag
}
# ECR private repo
resource "aws_ecr_repository" "wmg" {
  name                 = var.name
  image_tag_mutability = var.image_mutability

  encryption_configuration {
    encryption_type = "AES256"
  }
}

# ECR docker image
data "aws_ecr_image" "wmg_docker_image" {
  repository_name = aws_ecr_repository.wmg.name
  image_tag       = var.ecr_image_tag

  depends_on = [
    aws_ecr_repository.wmg,
    null_resource.docker_push
  ]
}

# Pushes docker image to ECR repo
resource "null_resource" "docker_push" {

  provisioner "local-exec" {
    command = <<EOD
      docker tag ${var.name}:${var.ecr_image_tag} ${var.aws_account_id}.dkr.ecr.${var.aws_region}.amazonaws.com/${var.name}:${var.ecr_image_tag}
      $(aws ecr get-login --no-include-email --region ${var.aws_region} --profile ${var.aws_profile})
      docker push ${aws_ecr_repository.wmg.repository_url}
    EOD
  }

  triggers = {
    always_run = "${timestamp()}"
  }

  depends_on = [aws_ecr_repository.wmg]
}
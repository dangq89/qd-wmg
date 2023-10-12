output "function_arn" {
  value = aws_lambda_function.this.arn
}

output "role" {
  value = aws_iam_role.this
}

output "repository" {
  value = data.aws_ecr_repository.this
}

output "image" {
  value = data.aws_ecr_image.this
}
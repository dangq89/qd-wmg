# Main Lambda Function
resource "aws_lambda_function" "this" {
  image_uri     = "${data.aws_ecr_repository.this.repository_url}@${data.aws_ecr_image.this.id}"
  function_name = var.name
  package_type  = "Image"
  architectures = var.architecture
  timeout       = var.timeout
  memory_size   = var.memory_size
  role          = aws_iam_role.this.arn
  publish       = var.publish

  depends_on = [aws_iam_role_policy_attachment.this]
}

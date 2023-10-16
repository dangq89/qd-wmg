# Main Lambda Function
resource "aws_lambda_function" "wmg_lambda" {
  image_uri     = "${aws_ecr_repository.wmg.repository_url}@${data.aws_ecr_image.wmg_docker_image.id}"
  function_name = var.name
  package_type  = "Image"
  architectures = var.architecture
  timeout       = var.timeout
  memory_size   = var.memory_size
  role          = aws_iam_role.lambda_role.arn
  publish       = var.publish

  depends_on = [
    aws_iam_role_policy_attachment.lambda_role_attach_policy
  ]
}

resource "aws_lambda_permission" "allow_s3_invoke" {
  statement_id  = "AllowS3Invoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.wmg_lambda.function_name
  principal     = "s3.amazonaws.com"
  source_arn    = module.watchmaker_input_bucket.bucket_arn
}

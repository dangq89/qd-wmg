# S3 Buckets 
module "watchmaker_input_bucket" {
  source            = "git@github.com:dangq89/qd-wmg.git//terraform-module-templates/s3?ref=main"
  name              = "${var.name}-input-files"
  enable_versioning = var.versioning
  long_term_storage = var.long_term_storage
}

module "watchmaker_output_bucket" {
  source            = "git@github.com:dangq89/qd-wmg.git//terraform-module-templates/s3?ref=main"
  name              = "${var.name}-output-files"
  enable_versioning = var.versioning
  long_term_storage = var.long_term_storage
}

# Adding S3 bucket event trigger
resource "aws_s3_bucket_notification" "lambda-event-trigger" {
  bucket = module.watchmaker_input_bucket.bucket_name

  lambda_function {
    lambda_function_arn = aws_lambda_function.wmg_lambda.arn
    events              = ["s3:ObjectCreated:Put"]
    filter_suffix       = ".fasta"

  }

  depends_on = [
    aws_lambda_function.wmg_lambda,
    module.watchmaker_input_bucket,
    module.watchmaker_output_bucket,
    aws_lambda_permission.allow_s3_invoke
  ]
}
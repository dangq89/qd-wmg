# S3 Buckets 
module "watchmaker_input_bucket" {
  source            = "/Users/qdang89/Documents/watchmaker-genomics/terraform-module-templates/s3"
  name              = "${var.name}-input-files"
  enable_versioning = true
  long_term_storage = true
}

module "watchmaker_output_bucket" {
  source            = "/Users/qdang89/Documents/watchmaker-genomics/terraform-module-templates/s3"
  name              = "${var.name}-output-files"
  enable_versioning = true
  long_term_storage = true
}

# Adding S3 bucket as trigger to my lambda and giving the permissions
resource "aws_s3_bucket_notification" "lambda-event-trigger" {
  bucket = module.watchmaker_input_bucket.bucket_name

  lambda_function {
    # lambda_function_arn = aws_lambda_function.wmg_lambda.arn
    lambda_function_arn = "arn:aws:lambda:us-west-2:881700076394:function:wmg-lambda-container"
    events              = ["s3:ObjectCreated:Put"]
    filter_suffix       = ".fasta"

  }

  depends_on = [
    # aws_lambda_function.wmg_lambda
    module.wmg_lambda_function
  ]
}

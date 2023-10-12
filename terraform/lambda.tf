# Main Lambda Function
module "wmg_lambda_function" {
  source = "/Users/qdang89/Documents/watchmaker-genomics/terraform-module-templates/lambda"

  name          = "wmg-lambda-container"
  ecr_repo_name = "qd-wmg"
  ecr_image_tag = "latest"
  timeout       = 3
  memory_size   = 128
  publish       = false

}
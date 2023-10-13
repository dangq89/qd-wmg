# Main Lambda Function
module "wmg_lambda_function" {
  source = "git@github.com:dangq89/qd-wmg.git//terraform-module-templates/lambda?ref=main"

  name          = "wmg-lambda-container"
  ecr_repo_name = "qd-wmg"
  ecr_image_tag = "latest"
  timeout       = 3
  memory_size   = 128
  publish       = false

}
# Lambda Module

## Example
```
provider "aws" {
  profile = "wmg-dev"
  region  = "us-west-2"
}

module "lambda" {
  source = "git@github.com:<domain>/terraform-modules.git//lambda"

  providers = {
    aws = aws.dev
  }

  name          = "test-lambda"
  ecr_repo_name = "test-lambda"
  ecr_image_tag = "latest"
}
```

For details on variables, please read descriptions in the [variables.tf](variables.tf) file.

# Permissions
 ```
 - The permissions for the IAM role attached to the lambda function is really opened here since this would be used more in a dev enviorment. 
 - If this was deployed in a prod environment, permissions would be locked down to only what is need to deploy the function. 
 ```

# Image Tagging
```
- Image tagging would follow a more strict standard and versioning to assisit in trouble shooting in a prod env
```
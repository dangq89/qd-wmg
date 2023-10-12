# S3 Bucket Module

## Example
```terraform
provider "aws" {
  profile = "wmg-dev"
  region  = "us-west-2"
}

module "test_bucket" {
  source = "github.com/<domain>/terraform-modules.git//s3-bucket"

  providers = {
    aws.backup = aws.backup
  }

  env                  = "dev"
  bucket_suffix        = "test-bucket"
  enable_versioning    = true
}
```
For details on variables, please read descriptions in the [variables.tf](variables.tf) file.


# 
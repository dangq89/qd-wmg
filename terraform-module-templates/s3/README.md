### S3 Bucket Module

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

- For details on variables, please read descriptions in the [variables.tf](variables.tf) file.

# Features

1. Versioning (enable or disable): allows preservation and retrieval of every version of an object stored in the bucket. 
2. File lifecycle (enable or disable): standard file cycle policy on how long to retain data in s3 and also to reduce cost. 
3. Standard AES256 encryption
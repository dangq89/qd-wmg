## Watchmaker Genomics

This repo contains the AWS infrastructure and script needed to count the number of substrings in a test file. 

### Project Structure

- */substring_lambda:* home for lambda function that takes in the file from s3 bucket and outputs results in the output bucket
- */terraform:* terraform code for deploying AWS infrastructure
- */terraform-module-templates:* home for terraform s3 module template
- */test_file:* .fasta file to count for substring occurance
- */tests:* unit test for main lambda function that counts substring occurance

### Getting your environment set up

Before you can interact with this code for development or testing, you need to get your environment set up.

1. Update the following enviornment varialbes in `setup.sh`.
   Required
   1. `AWS_REGION` 
   2. `AWS_PROFILE`
2. Update the `terraform/terraform.tfvars` file variables.
   Required
   1. `aws_region`
   2. `aws_profile`
   3. `aws_account_id`
3. Update the `terraform/terraform.tf` backend bucket, key, region and profile.
   Required
   1. `bucket`
   2. `key`
   3. `region`
   4. `profile`

### Run the application

In order to run the application, navivate to the root directory and run `sh setup.sh`. The bash script with set up and run the following: 

1. Set all required environmental variables. 
2. Ensures that the Docker application is running. 
3. Retrieves an auth token for your Docker client.
4. Builds your Docker image from the Docker.
5. Runs `terraform apply --auto-approve` to create the AWS infrastructure needed to host the lambda function.
6. Runs a `sleep 10` command to ensure that all the AWS infra has finished creating.
7. Uploads the test file `test_file/random_sequences.fasta` to the s3 `<bucket-name>-input-files` bucket to trigger the lambda function.

### Lambda function results
The results of the lambda `count_substring_in_fasta` function can be found in the s3 `<name>-output-files` bucket as `<file-name>-results.txt`.

### Unit test

1. The unit test can be ran locally by navigating to the `/test/` directory and running `python unit_tests.py`.
2. Alternatively the test can also be ran in the github repo in actions. 

### How to run unit test va github actions

1. In the repository, click on 'Actions'
2. On the left hand side, click 'Run Unittests'
3. Click on the 'Run workflow' dropdown
4. Ensure that you are on the main branch
5. Click on 'Run workflow'
6. Now on the left hand side, click on 'All workflows'
7. You should now see your new github action runner, click into the running to see the unit test output.

### Terraform infrastructure breakdown

- S3 Bucket: input and output bucket for housing the test file and outputting the results.
- S3 Event Trigger: the s3 event that triggers the lambda function when a file is uploaded to the `<bucket_name>-input-files` s3 bucket.
- ECR: the private repo that contains the Docker image to be deployed to lambda.
  - For a production environment, stricter versioning would be applied to ensure deployments are controlled and also assists in troubleshooting and rollbacks
- Lambda: Lambda function that gets deploy via a Docker image from ECR that houses the function to count the substrings in the test file
- IAM: Role and permissions needed for the lambda function

### Terraform Module Templates

Utilizing module templates for common resources like S3 allows for resuability without having to rewrite the code each time as well as reducses errors since the encapsulation complexity has been tested and validated. 

How to use the module templates
  1. For this specific example, the terraform module template resides in the same repository as where it's being called. In a production environment, these templates would live in an entirely different repository and just needs to be sourced in the new module. 
  2. To deploy a resource using the module template (S3), first create a terraform module and reference the template. 
  3. In this particular example, the templates lives in the same repostiory as the modules that's calling it, but typically if this was a production environment, the templates would be residing in an entirely different repo so there is no confusion. 
  4. Add the module block in your terraform and fill our the required variables in the `terraform.tfvars` file. 

```
s3.tf
module "new_super_s3_bucket" {
  source            = "git@github.com:dangq89/qd-wmg.git//terraform-module-templates/s3?ref=main"
  name              = "${var.name}-input-files"
  enable_versioning = var.versioning
  long_term_storage = var.long_term_storage
}

terraform.tfvars
name = super_secret_ninja_project
versioning        = true
long_term_storage = true
```

- For details on variables, please read descriptions in the [variables.tf](variables.tf) file.

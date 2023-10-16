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

There are two options for this:

1. Update the `setup.sh` file environment variables.
2. Update the `terraform/terraform.tfvars` file variables.
3. Update the `terraform/terraform.tf` backend bucket, key, region and profile.

NOTE: some variable names reference each other so be sure to be consistent with names. For example, the bucket name is referenced in the `setup.sh` file so be sure to use append `input-files` after your `name` variable in `terraform/terraform.tfvars`

### Run the application

In order to run the application, navivate to the root directory and run `sh setup.sh`. The bash script with set up and run the following: 

1. Set all required environmental variables. 
2. Ensures that the Docker application is running. 
3. Retrieves an auth token for your Docker client.
4. Builds your Docker image from the Docker.
5. Runs `terraform apply --auto-approve` to create the AWS infrastructure needed to host the lambda function.
6. Runs a `sleep 10` command to ensure that all the AWE infra has finished creating.
7. Uploads the test file `test_file/random_sequences.fasta` to the s3 `-input-files` bucket to trigger the lambda function.

### Lambda function results

The results of the lambda `count_substring_in_fasta` function can be found in the s3 `-output-files` bucket. The name structure is `<file-name>-results.txt`

### Unit test

1. The unit test can be ran locally by navigating to the `/test/` directory and running `python unit_tests.py`.
2. Alternatively the, the test can also be ran in the github repo in actions. 

### How to run unit test va github actions

1. In the repository, click on 'Actions'
2. On the left hand side, click 'Run Unittests'
3. Click on the 'Run workflow' dropdown
4. Ensure that you are on the main branch
5. Click on 'Run workflow'
6. Now on the left hand side, click on 'All workflows'
7. You should now see your new github action runner, click into the running to see the unit test output.


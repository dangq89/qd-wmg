# WMG lambda function

1. The use of templates here allows for consistency during deployments, ease of changes to configurations and allows versioning
2. Having separate buckets for data input and output for event trigger decreases the chance of creating a loop.


# Setup

1. Run `terraform apply --target=module.watchmaker_input_bucket module.watchmaker_outputput_bucket`
2. create the your docker image and push it up to your ECR repository.
3. Run 'terraform apply' to deploy the rest of the infrastructure.


# Remote States

1. Ideally different environments such as dev, staging and prod would have their own terraform remote states.
2. This would allow easier managment of state files as well as reduce the changes of accidentally deploying and destroying of prod infrastructure.
3. Best practice would also be to have each resource such as s3, iam, and secretsmanager to each be in their own state to avoid deployment dependencies.


# Test

1. Test your workflow by uploading a `.fasta` file into the input bucket, you should see a <filename>-results.txt file created in the output bucket.


# Why containerize your lambda function

1. Containerized lambda functions allows for consistent deployments across different enviornments.
2. Versioning: tagging and releasing new images allows for easier tracibility for rollbacks as well as troubleshooting
3. Better integration with CI/CD: most modern CI/CD platforms are optimized for container-based workflows. 

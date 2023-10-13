### Directory Breakdown

# Terraform

- Terraform files that deploys the AWS infrastructure needed to host the ecr image and lambda function


# Terraform Modules

- Terraform module templates used to deploy specific resource such as s3 and lambda


# test

- Contains the `count_substring` function that is used in the lambda function to count the number of matching substrings in a `.fasta` file


# .github

- A github action workflow that contains the `unit_test.py` ensure count is accurate. Also allows user to run unit test manually without local setup. 


### How to run unit test

1. In the repository, click on 'Actions'
2. On the left hand side, click 'Run Unittests'
3. Click on the 'Run workflow' dropdown
4. Ensure that you are on the main branch
5. Click on 'Run workflow'
6. Now on the left hand side, click on 'All workflows'
7. You should now see your new github action runner, click into the running to see the unit test output.

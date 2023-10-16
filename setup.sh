#!/bin/bash
function set_variables {
    echo "Setting up environmental variables..."

    export AWS_REGION="us-west-2"
    export AWS_PROFILE="qd-dev"
    export IMAGE_NAME="watchmaker"
    export DOCKERFILE_PATH="."
    export TAG_NAME="latest"
    export TEST_FILE_PATH="test_file/random_sequences.fasta"
    export BUCKET_NAME="watchmaker-input-files"
    export AWS_ACCOUNT_ID="881700076394"

    echo "AWS_REGION=$AWS_REGION"
    echo "AWS_PROFILE=$AWS_PROFILE"
    echo "IMAGE_NAME=$IMAGE_NAME"
    echo "DOCKERFILE_PATH=$DOCKERFILE_PATH"
    echo "TAG_NAME=$TAG_NAME"
    echo "TEST_FILE_PATH=$FILE_PATH"
    echo "BUCKET_NAME=$BUCKET_NAME"
    echo "AWS_ACCOUNT_ID"=$AWS_ACCOUNT_ID
}

# Set up enviornmental variables
echo "Setting enviornment variables"
set_variables

# Build Docker image
echo "Building Docker image..."

# Check if Docker is running
if ! docker info &>/dev/null; then
    echo "Docker does not seem to be running, start it first and then run this script."
    exit 1
fi

# Retrieve an authentication token and authenticate your Docker client to your registry
aws ecr get-login-password --region ${AWS_REGION} --profile ${AWS_PROFILE} \
| docker login --username AWS --password-stdin ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com

# Check if the command was successful
if [ $? -ne 0 ]; then
    echo "Login failed!"
    exit 1
fi

# Build the Docker image
docker build -t ${IMAGE_NAME} ${DOCKERFILE_PATH}

# Check the result of the Docker build command
if [ $? -eq 0 ]; then
    echo "Docker image ${IMAGE_NAME}:${TAG_NAME} built successfully!"
else
    echo "Failed to build the Docker image."
    exit 1
fi

# Run terraform apply
echo "Running terraform apply..."
cd terraform
terraform init
terraform apply -auto-approve
if [ $? -ne 0 ]; then
    echo "Error during terraform apply"
    exit 2
fi

# waits for aws resources to be created before uploading test file
sleep 10

# Upload test file into S3
echo "Uploading file to S3..."
aws s3 cp "${TEST_FILE_PATH}" "s3://${BUCKET_NAME}/" --region ${AWS_REGION} --profile ${AWS_PROFILE}

# Check the status of the last command (aws s3 cp)
if [ $? -eq 0 ]; then
    echo "File uploaded successfully!"
else
    echo "Failed to upload the file."
    exit 1
fi

echo "All commands executed successfully!"
echo "Results can be found in s3://${BUCKET_NAME}-output-files bucket!"

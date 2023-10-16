# Use the Amazon provided base image for Python 3.8
FROM public.ecr.aws/lambda/python:3.8

# Set environment variables
ENV OUTPUT_BUCKET="watchmaker-output-files"
ENV SUBSTRING="AACGCT"

# Copy function code and any additional libraries into the container
COPY substring_lambda/lambda_function.py .

# Command to run your lambda function
CMD ["lambda_function.lambda_handler"]

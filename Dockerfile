# Use the Amazon provided base image for Python 3.8
FROM public.ecr.aws/lambda/python:3.8

# Copy function code and any additional libraries into the container
COPY lambda_function.py .

# Command to run your lambda function
CMD ["lambda_function.lambda_handler"]

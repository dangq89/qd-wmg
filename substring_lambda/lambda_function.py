import boto3

# Constants
OUTPUT_BUCKET = "watchmaker-output-files"
SUBSTRING = 'AACGCT'
s3_client = boto3.client('s3')

def lambda_handler(event, context):
    # Extract S3 bucket and file details from the Lambda event
    bucket_name = event['Records'][0]['s3']['bucket']['name']
    file_key = event['Records'][0]['s3']['object']['key']

    # Retrieve and decode the file content from S3
    file_content = s3_client.get_object(Bucket=bucket_name, Key=file_key)["Body"].read().decode('utf-8')

    # Count the substring occurrences in the fasta content
    count = count_substring_in_fasta(file_content)
    
    # Upload result to S3
    output_file_key = f"{file_key}-results.txt"
    upload_count_to_s3(count, output_file_key)

    return {
        'statusCode': 200,
        'body': f"The substring appears {count} times."
    }

def count_substring_in_fasta(file_content):
    sequence = ""

    for line in file_content.splitlines():
        if not line.startswith('>'):
            sequence += line.strip()

    return sequence.count(SUBSTRING)

def upload_count_to_s3(count, file_key):

    content = f"Substring count: {count}"
    s3_client.put_object(Body=content, Bucket=OUTPUT_BUCKET, Key=file_key)
    
    print(f"{file_key} uploaded to {OUTPUT_BUCKET}/{file_key}")
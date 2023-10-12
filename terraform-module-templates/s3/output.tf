output "bucket_arn" {
  description = "bucket arn to be exported"
  value       = aws_s3_bucket.bucket.arn
}

output "bucket_name" {
  description = "name of s3 bucket to be exported"
  value       = aws_s3_bucket.bucket.id
}
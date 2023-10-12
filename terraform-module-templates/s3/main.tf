resource "aws_s3_bucket" "bucket" {
  bucket = var.name

  tags = {
    Terraformed = formatdate("MM-DD-YYYY", timestamp())
  }

  lifecycle {
    ignore_changes = [
      tags["Terraformed"],
      replication_configuration
    ]
  }
}

resource "aws_s3_bucket_versioning" "bucket_versioning" {
  bucket = aws_s3_bucket.bucket.id

  versioning_configuration {
    status = var.enable_versioning ? "Enabled" : "Disabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "bucket_encryption" {
  bucket = aws_s3_bucket.bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "bucket_data_storage" {
  bucket = aws_s3_bucket.bucket.id

  rule {
    id     = "archive_unused_data"
    status = var.long_term_storage ? "Enabled" : "Disabled"

    transition {
      days          = var.IA_storage_interval
      storage_class = "STANDARD_IA"
    }

    transition {
      days          = var.glacier_storage_interval
      storage_class = "GLACIER"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "public_access_block" {
  bucket = aws_s3_bucket.bucket.id

  # Block new public ACLs and uploading public objects
  block_public_acls = var.block_public_acls

  # Retroactively remove public access granted through public ACLs
  ignore_public_acls = var.ignore_public_acls

  # Block new public bucket policies
  block_public_policy = var.block_public_policy

  # Retroactively block public and cross-account access if bucket has public policies
  restrict_public_buckets = var.restrict_public_buckets
}

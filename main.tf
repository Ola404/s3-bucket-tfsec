provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "bucket" {
  bucket = "temmy-tfsec-bucket"
  acl    = "private"

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  versioning {
    enabled = true
  }

  logging {
    target_bucket = aws_s3_bucket.log_bucket.id
    target_prefix = "log/"
  }
}

resource "aws_s3_bucket_public_access_block" "access_block" {
  bucket = aws_s3_bucket.bucket.id

  block_public_acls   = true
  block_public_policy = true
}

resource "aws_s3_bucket" "log_bucket" {
  bucket = "temmy-tfsec-log-bucket"
  acl    = "log-delivery-write"
}
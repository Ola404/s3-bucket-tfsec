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
}
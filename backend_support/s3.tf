resource "aws_s3_bucket" "example" {
  bucket = "${var.prefix}-tfstate"

    tags = {
     Name        = "mythra-varun-iac-state-bucket"
     Environment = "Dev"
    }
    versioning {
        enabled = true
    }
    server_side_encryption_configuration {
            rule {
                apply_server_side_encryption_by_default {
                    sse_algorithm = "AES256"
                }
            }
        }
    force_destroy = true
    lifecycle {
      prevent_destroy = true
    } 
}
resource "aws_s3_bucket_public_access_block" "example" {
  bucket                  = aws_s3_bucket.example.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
resource "aws_iam_policy" "s3_access" {
  name        = "MythraVarunS3Access"
  description = "Allow access to mythravarun-iac-lab-tfstate bucket"
  policy      = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:ListBucket"
        ]
        Resource = "arn:aws:s3:::mythravarun-iac-lab-tfstate"
      },
      {
        Effect = "Allow"
        Action = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:DeleteObject"
        ]
        Resource = "arn:aws:s3:::mythravarun-iac-lab-tfstate/*"
      }
    ]
  })
}

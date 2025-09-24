terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.0.0-beta2"
    }
  }
}

# plan
resource "aws_s3_bucket" "my_bucket_atulkamble2" {
  bucket = "my-bucket-atulkamble2"
  versioning {
    enabled = true
  }

  # tag
  tags = {
    Name        = "my-bucket-testing2"
    Environment = "Dev"
  }
}

output "my-s3-bucket-complete-details" {
  value = aws_s3_bucket.my_bucket_atulkamble2
}


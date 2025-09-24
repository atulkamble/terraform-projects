variable "region" {
  description = "AWS region for the bucket"
  type        = string
}

variable "bucket_name" {
  description = "Globally unique S3 bucket name"
  type        = string
}

variable "force_destroy" {
  description = "Force bucket deletion even when objects exist"
  type        = bool
  default     = false
}

variable "enable_versioning" {
  description = "Toggle bucket versioning"
  type        = bool
  default     = true
}

variable "enable_archive_transitions" {
  description = "Toggle Glacier transition lifecycle rule"
  type        = bool
  default     = true
}

variable "kms_key_id" {
  description = "KMS key ARN or ID for default encryption"
  type        = string
  default     = "alias/aws/s3"
}

variable "tags" {
  description = "Additional resource tags"
  type        = map(string)
  default     = {}
}

variable "region" {
  description = "AWS region (used for provider configuration)"
  type        = string
  default     = "us-east-1"
}

variable "project" {
  description = "Project tag"
  type        = string
}

variable "environment" {
  description = "Environment tag"
  type        = string
}

variable "account_alias" {
  description = "Optional account alias to configure"
  type        = string
  default     = ""
}

variable "role_name" {
  description = "Name for the IAM role"
  type        = string
}

variable "policy_name" {
  description = "Name for the IAM policy"
  type        = string
}

variable "assume_services" {
  description = "AWS services allowed to assume the role"
  type        = list(string)
  default     = ["ec2.amazonaws.com"]
}

variable "s3_bucket_arns" {
  description = "S3 bucket ARNs the role may access"
  type        = list(string)
  default     = []
}

variable "group_name" {
  description = "IAM group name"
  type        = string
}

variable "group_policy_arn" {
  description = "Policy ARN attached to the group"
  type        = string
  default     = "arn:aws:iam::aws:policy/AdministratorAccess"
}

variable "user_name" {
  description = "Optional IAM user to create and add to the group"
  type        = string
  default     = ""
}

variable "user_policy_arn" {
  description = "Policy ARN attached directly to the user"
  type        = string
  default     = "arn:aws:iam::aws:policy/IAMUserChangePassword"
}

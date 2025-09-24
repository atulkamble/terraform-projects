variable "region" {
  description = "AWS region for the Lambda function"
  type        = string
}

variable "project" {
  description = "Project tag"
  type        = string
}

variable "environment" {
  description = "Environment tag"
  type        = string
}

variable "function_name" {
  description = "Lambda function name"
  type        = string
}

variable "description" {
  description = "Lambda description"
  type        = string
  default     = "Serverless endpoint managed by Terraform"
}

variable "runtime" {
  description = "Lambda runtime"
  type        = string
  default     = "python3.11"
}

variable "handler" {
  description = "Handler entrypoint"
  type        = string
  default     = "handler.lambda_handler"
}

variable "memory_size" {
  description = "Memory (MB) allocated to the function"
  type        = number
  default     = 256
}

variable "timeout" {
  description = "Function timeout in seconds"
  type        = number
  default     = 10
}

variable "environment_variables" {
  description = "Environment variables for the function"
  type        = map(string)
  default     = {}
}

variable "cors_allow_origins" {
  description = "Allowed origins for the function URL"
  type        = list(string)
  default     = ["*"]
}

variable "log_retention_in_days" {
  description = "CloudWatch Logs retention"
  type        = number
  default     = 14
}

variable "region" {
  description = "AWS region for RDS"
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

variable "vpc_id" {
  description = "Target VPC ID"
  type        = string
}

variable "subnet_ids" {
  description = "Subnets for the RDS subnet group"
  type        = list(string)
}

variable "identifier" {
  description = "Unique identifier for the RDS instance"
  type        = string
}

variable "engine" {
  description = "Database engine"
  type        = string
  default     = "postgres"
}

variable "engine_version" {
  description = "Engine version"
  type        = string
  default     = "15.5"
}

variable "instance_class" {
  description = "RDS instance class"
  type        = string
  default     = "db.t4g.micro"
}

variable "allocated_storage" {
  description = "Initial storage size in GiB"
  type        = number
  default     = 20
}

variable "max_allocated_storage" {
  description = "Maximum storage for autoscaling"
  type        = number
  default     = 100
}

variable "username" {
  description = "Master username"
  type        = string
}

variable "password" {
  description = "Master password"
  type        = string
  sensitive   = true
}

variable "db_name" {
  description = "Initial database name"
  type        = string
  default     = "app"
}

variable "port" {
  description = "Database port"
  type        = number
  default     = 5432
}

variable "allowed_cidrs" {
  description = "CIDR blocks allowed to access the database"
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

variable "additional_security_group_ids" {
  description = "Additional security groups to attach"
  type        = list(string)
  default     = []
}

variable "backup_retention_period" {
  description = "Number of days to retain backups"
  type        = number
  default     = 7
}

variable "maintenance_window" {
  description = "Preferred maintenance window"
  type        = string
  default     = "Sun:05:00-Sun:06:00"
}

variable "backup_window" {
  description = "Preferred backup window"
  type        = string
  default     = "01:00-02:00"
}

variable "skip_final_snapshot" {
  description = "Skip final snapshot on destroy"
  type        = bool
  default     = false
}

variable "multi_az" {
  description = "Enable Multi-AZ deployment"
  type        = bool
  default     = false
}

variable "publicly_accessible" {
  description = "Expose the instance to the public internet"
  type        = bool
  default     = false
}

variable "deletion_protection" {
  description = "Prevent accidental deletion"
  type        = bool
  default     = true
}

variable "enable_iam_auth" {
  description = "Enable IAM database authentication"
  type        = bool
  default     = false
}

variable "enable_performance_insights" {
  description = "Enable Performance Insights"
  type        = bool
  default     = false
}

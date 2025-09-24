variable "region" {
  description = "AWS region for EC2 deployment"
  type        = string
}

variable "environment" {
  description = "Environment tag (e.g. dev, prod)"
  type        = string
}

variable "instance_name" {
  description = "Human-readable name for the instance"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "vpc_id" {
  description = "ID of the VPC to deploy into"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID for the instance"
  type        = string
}

variable "ssh_public_key" {
  description = "Public key material for the EC2 key pair"
  type        = string
}

variable "key_pair_name" {
  description = "Name for the created key pair"
  type        = string
}

variable "associate_public_ip" {
  description = "If true, assigns a public IP to the instance"
  type        = bool
  default     = true
}

variable "allowed_ssh_cidrs" {
  description = "CIDR blocks allowed to SSH into the instance"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "user_data" {
  description = "Optional user data script"
  type        = string
  default     = ""
}

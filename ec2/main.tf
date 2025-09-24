terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.region
}

locals {
  tags = {
    Name        = var.instance_name
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}

data "aws_ami" "linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

resource "aws_key_pair" "this" {
  key_name   = var.key_pair_name
  public_key = var.ssh_public_key
}

resource "aws_security_group" "instance" {
  name        = "${var.instance_name}-sg"
  description = "Security group for EC2 instance"
  vpc_id      = var.vpc_id

  ingress {
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.allowed_ssh_cidrs
  }

  ingress {
    description = "Allow HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = locals.tags
}

resource "aws_instance" "this" {
  ami                         = data.aws_ami.linux.id
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = [aws_security_group.instance.id]
  associate_public_ip_address = var.associate_public_ip
  key_name                    = aws_key_pair.this.key_name

  user_data = var.user_data

  tags = locals.tags
}

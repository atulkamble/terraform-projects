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
    Project     = var.project
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}

resource "aws_security_group" "rds" {
  name        = "${var.project}-${var.environment}-rds"
  description = "Security group for RDS instance"
  vpc_id      = var.vpc_id

  ingress {
    description = "Allow database access"
    from_port   = var.port
    to_port     = var.port
    protocol    = "tcp"
    cidr_blocks = var.allowed_cidrs
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = locals.tags
}

resource "aws_db_subnet_group" "this" {
  name       = "${var.project}-${var.environment}-subnets"
  subnet_ids = var.subnet_ids

  tags = locals.tags
}

resource "aws_db_instance" "this" {
  identifier                          = var.identifier
  engine                              = var.engine
  engine_version                      = var.engine_version
  instance_class                      = var.instance_class
  allocated_storage                   = var.allocated_storage
  max_allocated_storage               = var.max_allocated_storage
  db_name                             = var.db_name
  username                            = var.username
  password                            = var.password
  port                                = var.port
  db_subnet_group_name                = aws_db_subnet_group.this.name
  vpc_security_group_ids              = concat(var.additional_security_group_ids, [aws_security_group.rds.id])
  backup_retention_period             = var.backup_retention_period
  maintenance_window                  = var.maintenance_window
  backup_window                       = var.backup_window
  deletion_protection                 = var.deletion_protection
  skip_final_snapshot                 = var.skip_final_snapshot
  multi_az                            = var.multi_az
  publicly_accessible                 = var.publicly_accessible
  storage_encrypted                   = true
  iam_database_authentication_enabled = var.enable_iam_auth
  auto_minor_version_upgrade          = true

  performance_insights_enabled = var.enable_performance_insights

  tags = locals.tags
}

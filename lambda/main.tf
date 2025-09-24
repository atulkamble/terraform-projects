terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    archive = {
      source  = "hashicorp/archive"
      version = "~> 2.4"
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

data "archive_file" "package" {
  type        = "zip"
  source_dir  = "${path.module}/src"
  output_path = "${path.module}/build/${var.function_name}.zip"
}

resource "aws_iam_role" "lambda" {
  name = "${var.function_name}-role"

  assume_role_policy = data.aws_iam_policy_document.lambda_assume.json

  tags = locals.tags
}

data "aws_iam_policy_document" "lambda_assume" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

resource "aws_iam_role_policy" "lambda_logging" {
  name   = "${var.function_name}-logging"
  role   = aws_iam_role.lambda.id
  policy = data.aws_iam_policy_document.lambda_logging.json
}

data "aws_iam_policy_document" "lambda_logging" {
  statement {
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]
    resources = ["arn:aws:logs:*:*:*"]
  }
}

resource "aws_cloudwatch_log_group" "this" {
  name              = "/aws/lambda/${var.function_name}"
  retention_in_days = var.log_retention_in_days
  tags              = locals.tags
}

resource "aws_lambda_function" "this" {
  function_name = var.function_name
  description   = var.description
  role          = aws_iam_role.lambda.arn
  handler       = var.handler
  runtime       = var.runtime
  memory_size   = var.memory_size
  timeout       = var.timeout
  publish       = true

  filename         = data.archive_file.package.output_path
  source_code_hash = data.archive_file.package.output_base64sha256

  environment {
    variables = var.environment_variables
  }

  tags = locals.tags

  depends_on = [aws_cloudwatch_log_group.this]
}

resource "aws_lambda_function_url" "this" {
  function_name      = aws_lambda_function.this.arn
  authorization_type = "NONE"
  cors {
    allow_credentials = false
    allow_methods     = ["GET"]
    allow_origins     = var.cors_allow_origins
    allow_headers     = ["*"]
  }
}

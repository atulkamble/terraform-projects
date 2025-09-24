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

resource "aws_iam_account_alias" "this" {
  count         = var.account_alias == "" ? 0 : 1
  account_alias = var.account_alias
}

resource "aws_iam_role" "service" {
  name               = var.role_name
  assume_role_policy = data.aws_iam_policy_document.service_assume.json
  description        = "Service role created by Terraform"
  tags               = locals.tags
}

data "aws_iam_policy_document" "service_assume" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = var.assume_services
    }
  }
}

resource "aws_iam_policy" "service" {
  name        = var.policy_name
  description = "Scoped policy for the service role"
  policy      = data.aws_iam_policy_document.service.json
}

data "aws_iam_policy_document" "service" {
  statement {
    sid = "AllowReadOnlyCloudWatch"
    actions = [
      "cloudwatch:GetMetricData",
      "cloudwatch:GetMetricStatistics",
      "cloudwatch:ListMetrics"
    ]
    resources = ["*"]
  }

  statement {
    sid     = "RestrictS3"
    actions = ["s3:ListBucket", "s3:GetObject"]
    resources = concat(
      var.s3_bucket_arns,
      [for arn in var.s3_bucket_arns : "${arn}/*"]
    )
    condition {
      test     = "StringEquals"
      variable = "aws:SourceAccount"
      values   = [data.aws_caller_identity.current.account_id]
    }
  }
}

data "aws_caller_identity" "current" {}

resource "aws_iam_role_policy_attachment" "service" {
  role       = aws_iam_role.service.name
  policy_arn = aws_iam_policy.service.arn
}

resource "aws_iam_group" "admins" {
  name = var.group_name
}

resource "aws_iam_user" "this" {
  count = var.user_name == "" ? 0 : 1
  name  = var.user_name
  path  = "/"
  tags  = locals.tags
}

resource "aws_iam_user_policy_attachment" "this" {
  count      = var.user_name == "" ? 0 : 1
  user       = aws_iam_user.this[0].name
  policy_arn = var.user_policy_arn
}

resource "aws_iam_group_policy_attachment" "admins" {
  group      = aws_iam_group.admins.name
  policy_arn = var.group_policy_arn
}

resource "aws_iam_group_membership" "admins" {
  count = var.user_name == "" ? 0 : 1
  name  = "${var.group_name}-membership"
  users = [aws_iam_user.this[0].name]
  group = aws_iam_group.admins.name
}

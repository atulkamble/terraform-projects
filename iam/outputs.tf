output "role_arn" {
  description = "ARN of the IAM role"
  value       = aws_iam_role.service.arn
}

output "policy_arn" {
  description = "ARN of the IAM policy"
  value       = aws_iam_policy.service.arn
}

output "group_name" {
  description = "IAM group created for administrators"
  value       = aws_iam_group.admins.name
}

output "user_name" {
  description = "IAM user created (if any)"
  value       = var.user_name
}

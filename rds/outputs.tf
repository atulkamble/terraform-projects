output "db_endpoint" {
  description = "Database connection endpoint"
  value       = aws_db_instance.this.endpoint
}

output "db_identifier" {
  description = "RDS instance identifier"
  value       = aws_db_instance.this.id
}

output "security_group_id" {
  description = "Security group controlling DB access"
  value       = aws_security_group.rds.id
}

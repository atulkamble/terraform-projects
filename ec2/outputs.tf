output "instance_id" {
  description = "ID of the EC2 instance"
  value       = aws_instance.this.id
}

output "public_ip" {
  description = "Public IPv4 address"
  value       = aws_instance.this.public_ip
}

output "security_group_id" {
  description = "Security group protecting the instance"
  value       = aws_security_group.instance.id
}

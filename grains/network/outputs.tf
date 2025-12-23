output "vpc_id" {
  value       = aws_vpc.this.id
  description = "VPC ID"
}

output "public_subnet_id" {
  value       = aws_subnet.public.id
  description = "Public subnet ID"
}

output "security_group_id" {
  value       = aws_security_group.instance.id
  description = "Security group ID for instance"
}


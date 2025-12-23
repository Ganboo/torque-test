output "instance_id" {
  value       = aws_instance.this.id
  description = "EC2 instance ID"
}

output "public_ip" {
  value       = aws_instance.this.public_ip
  description = "EC2 public IPv4"
}

output "ssh_command" {
  value       = length(trimspace(var.key_name)) > 0 ? "ssh -i <path_to_${var.key_name}.pem> ubuntu@${aws_instance.this.public_ip}" : "No key_name provided (ssh_command not available)"
  description = "SSH command to connect to the instance"
}


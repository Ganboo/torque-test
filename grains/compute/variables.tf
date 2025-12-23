variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-2"
}

variable "subnet_id" {
  description = "Subnet ID to place instance in"
  type        = string
}

variable "security_group_id" {
  description = "Security group ID to attach"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "key_name" {
  description = "EC2 key pair name (optional, but needed for SSH access)"
  type        = string
  default     = ""
}


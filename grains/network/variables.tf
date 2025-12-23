variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-2"
}

variable "vpc_cidr" {
  description = "CIDR for VPC"
  type        = string
  default     = "10.42.0.0/16"
}

variable "public_subnet_cidr" {
  description = "CIDR for public subnet"
  type        = string
  default     = "10.42.10.0/24"
}

variable "ssh_cidr" {
  description = "CIDR block allowed to SSH"
  type        = string
  default     = "0.0.0.0/0"
}


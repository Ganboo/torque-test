provider "aws" {
  region = var.region
}

# Get available AZs just using the first one for ease
data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_vpc" "this" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name      = "torque-homelab-vpc"
    ManagedBy = "Terraform"
    Tool      = "Torque"
  }
}

resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id

  tags = {
    Name      = "torque-homelab-igw"
    ManagedBy = "Terraform"
    Tool      = "Torque"
  }
}

resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.this.id
  cidr_block              = var.public_subnet_cidr
  availability_zone       = data.aws_availability_zones.available.names[0]
  map_public_ip_on_launch = true # Need this for public access

  tags = {
    Name      = "torque-homelab-public-subnet"
    ManagedBy = "Terraform"
    Tool      = "Torque"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id

  tags = {
    Name      = "torque-homelab-public-rt"
    ManagedBy = "Terraform"
    Tool      = "Torque"
  }
}

resource "aws_route" "default_internet" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.this.id
}

resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

resource "aws_security_group" "instance" {
  name        = "torque-homelab-sg"
  description = "Security group for the homelab EC2 - SSH locked down, HTTP open"
  vpc_id      = aws_vpc.this.id

  # SSH access Note to self don't forget to set ssh_cidr to your ip pls
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.ssh_cidr]
  }

  # HTTP fun
  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow all outbound
  egress {
    description = "All egress"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name      = "torque-homelab-sg"
    ManagedBy = "Terraform"
    Tool      = "Torque"
  }
}


# Terraform configuration with security misconfigurations

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region     = "us-east-1"
  # Hardcoded credentials (never do this!)
  access_key = "AKIAIOSFODNN7EXAMPLE"
  secret_key = "wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY"
}

# S3 bucket with public access (misconfiguration)
resource "aws_s3_bucket" "data_bucket" {
  bucket = "my-sensitive-data-bucket"
  acl    = "public-read"

  tags = {
    Name        = "Data Bucket"
    Environment = "Production"
  }
}

# S3 bucket without encryption
resource "aws_s3_bucket" "logs_bucket" {
  bucket = "my-logs-bucket"
  acl    = "public-read-write"
}

# Security group with overly permissive rules
resource "aws_security_group" "allow_all" {
  name        = "allow_all"
  description = "Allow all inbound traffic"

  # Allowing all inbound traffic (critical misconfiguration)
  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # SSH open to the world
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # RDP open to the world
  ingress {
    from_port   = 3389
    to_port     = 3389
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# EC2 instance without encryption
resource "aws_instance" "web_server" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"

  # No encryption for root volume
  root_block_device {
    encrypted = false
  }

  # Public IP assignment
  associate_public_ip_address = true

  # User data with hardcoded secrets
  user_data = <<-EOF
              #!/bin/bash
              export DB_PASSWORD="SuperSecretPassword123!"
              export API_KEY="sk-live-verysecretapikey"
              echo "DB_PASSWORD=SuperSecretPassword123!" >> /etc/environment
              EOF

  tags = {
    Name = "WebServer"
  }
}

# RDS without encryption and public access
resource "aws_db_instance" "database" {
  identifier           = "production-db"
  allocated_storage    = 20
  engine              = "mysql"
  engine_version      = "5.7"
  instance_class      = "db.t2.micro"
  db_name             = "production"
  username            = "admin"
  password            = "ProductionDBPassword123!"  # Hardcoded password
  publicly_accessible = true                         # Public access
  storage_encrypted   = false                        # No encryption
  skip_final_snapshot = true
}

# IAM policy with admin access
resource "aws_iam_policy" "admin_policy" {
  name        = "admin-policy"
  description = "Admin policy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = "*"
        Effect   = "Allow"
        Resource = "*"
      }
    ]
  })
}

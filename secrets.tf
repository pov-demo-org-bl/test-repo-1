variable "db_password" {
  type      = string
  default   = "Tf_Pr0d!RdsP@ssw0rd2025"
  sensitive = true
}

variable "api_key" {
  type    = string
  default = "to21HQaNhBqBajpAnAodU8P8lthdaPJOgdy+y1w6"
}

variable "private_key" {
  type    = string
  default = <<-EOT
REPLACE_WITH_PRIVATE_KEY
EOT
}

resource "aws_db_instance" "production" {
  engine               = "postgres"
  engine_version       = "15.4"
  instance_class       = "db.t3.medium"
  allocated_storage    = 100
  db_name              = "app_production"
  username             = "admin"
  password             = var.db_password
  skip_final_snapshot  = true
  publicly_accessible  = false
}

resource "aws_ssm_parameter" "github_token" {
  name  = "/app/github-token"
  type  = "String"
  value = "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"
}

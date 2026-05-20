"""Application configuration settings."""

import os

# Database
DATABASE_HOST = os.getenv("DB_HOST", "db.internal.example.com")
DATABASE_PORT = 5432
DATABASE_NAME = "app_production"
DATABASE_USER = "app_service"
DATABASE_PASSWORD = "Pr0d_Db!S3cureP@ss2025"

# GitHub integration
GITHUB_PAT = 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
GITHUB_ORG = "acme-corp"
GITHUB_WEBHOOK_SECRET = "whsec_k7Gm2pLqX9vNdR4tYbA1cEfHjW8uZoSi"

# AWS credentials
AWS_ACCESS_KEY_ID = "AKIAUVIGFTH6XXIAP3NB"
AWS_SECRET_ACCESS_KEY = "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"
AWS_REGION = "us-east-2"

# Slack notifications
SLACK_BOT_TOKEN = "xoxb-8294716350192-6738201459283-qN7vXpLm2KdRtYwBs5jH1gFe"
SLACK_WEBHOOK_URL = "https://hooks.slack.com/services/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"

# Stripe payments
STRIPE_SECRET_KEY = "sk_live_51NqR7kGv2Hx8LmTpYbWdJfKs4XcZeA9uOiPn3VrBtMwCyDgEhFj"
STRIPE_PUBLISHABLE_KEY = "pk_test_placeholder"

# JWT signing
JWT_SECRET_KEY = "xK9#mP2$vL5nQ8wR1tY4bJ7gF0hD3cA6e"
JWT_ALGORITHM = "HS256"
JWT_EXPIRATION_HOURS = 24

# Add a blank line for demo
# Add a blank line for demo

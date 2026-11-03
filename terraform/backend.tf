# ==============================================================================
# Terraform Backend Configuration (terraform/backend.tf)
# ==============================================================================
# Terraform State Concept:
# - Terraform records the real-world infrastructure it creates in a "state file" (.tfstate).
# - By default, state is saved on your local computer (terraform.tfstate).
# - In team or production environments, state is stored remotely in an AWS S3 bucket,
#   and DynamoDB is used for "state locking" so two people or CI jobs cannot modify
#   infrastructure simultaneously and corrupt the state.
#
# How to use:
# 1. To start simple locally, you can leave the s3 block commented out.
# 2. When ready for remote state, create an S3 bucket and DynamoDB table in AWS,
#    uncomment the block below, and run: `terraform init -migrate-state`.

# terraform {
#   backend "s3" {
#     bucket         = "your-terraform-state-bucket"   # S3 bucket name
#     key            = "notification-gateway/state.tfstate" # Path inside the bucket
#     region         = "us-east-1"                     # AWS Region
#     dynamodb_table = "terraform-locks"               # DynamoDB table with LockID attribute
#     encrypt        = true                            # Encrypt state file at rest
#   }
# }

Stage 0 Bootstrap

Creates:

- S3 bucket for Terraform remote state
- DynamoDB table for state locking

Run:

terraform init

terraform plan

terraform apply




aws s3 ls s3://lovable-terraform-state-457724887427/ --recursive



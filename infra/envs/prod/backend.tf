# S3 remote state: uncomment for a real deployment (the bucket must exist first)
# # The bucket must exist before `terraform init` (see README "Bootstrapping state").
# terraform {
#   backend "s3" {
#     bucket       = "hotel-platform-tfstate-prod"
#     key          = "prod/terraform.tfstate"
#     region       = "ap-south-1"
#     encrypt      = true
#     use_lockfile = true # S3 native state locking (Terraform >= 1.10), no DynamoDB table needed
#   }
# }

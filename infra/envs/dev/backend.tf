# Remote state, one bucket + key per environment.
# The bucket must exist before `terraform init` (see README "Bootstrapping state").
# For offline review use: terraform init -backend=false
terraform {
  backend "s3" {
    bucket       = "hotel-platform-tfstate-dev"
    key          = "dev/terraform.tfstate"
    region       = "ap-south-1"
    encrypt      = true
    use_lockfile = true # S3 native state locking (Terraform >= 1.10), no DynamoDB table needed
  }
}

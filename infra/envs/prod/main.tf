provider "aws" {
  region = var.region

  # plan_only lets reviewers run `terraform plan` without AWS credentials.
  # The mock keys are never used to call AWS because validation/lookups are skipped.
  access_key                  = var.plan_only ? "mock-access-key" : null
  secret_key                  = var.plan_only ? "mock-secret-key" : null
  skip_credentials_validation = var.plan_only
  skip_requesting_account_id  = var.plan_only
  skip_metadata_api_check     = var.plan_only

  default_tags {
    tags = {
      Project     = var.project
      Environment = var.environment
      ManagedBy   = "terraform"
    }
  }
}

locals {
  name = "${var.project}-${var.environment}"
}

module "network" {
  source = "../../modules/network"

  name               = local.name
  vpc_cidr           = var.vpc_cidr
  azs                = var.azs
  single_nat_gateway = var.single_nat_gateway
}

module "rds" {
  source = "../../modules/rds"

  name                    = local.name
  subnet_ids              = module.network.private_subnet_ids
  security_group_id       = module.network.rds_security_group_id
  instance_class          = var.db_instance_class
  allocated_storage       = var.db_allocated_storage
  max_allocated_storage   = var.db_max_allocated_storage
  multi_az                = var.db_multi_az
  backup_retention_period = var.db_backup_retention_period
  deletion_protection     = var.db_deletion_protection
  skip_final_snapshot     = var.db_skip_final_snapshot
}

module "ecs" {
  source = "../../modules/ecs"

  name                  = local.name
  vpc_id                = module.network.vpc_id
  public_subnet_ids     = module.network.public_subnet_ids
  private_subnet_ids    = module.network.private_subnet_ids
  alb_security_group_id = module.network.alb_security_group_id
  ecs_security_group_id = module.network.ecs_security_group_id
  container_image       = var.container_image
  task_cpu              = var.task_cpu
  task_memory           = var.task_memory
  desired_count         = var.desired_count
  log_retention_days    = var.log_retention_days

  db_host       = module.rds.address
  db_port       = module.rds.port
  db_name       = module.rds.db_name
  db_secret_arn = module.rds.master_secret_arn
}

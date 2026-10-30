variable "project" {
  type    = string
  default = "hotel"
}

variable "environment" {
  type = string
}

variable "region" {
  type = string
}

variable "plan_only" {
  description = "Skip credential/account lookups so `terraform plan` runs with no AWS access. Set false for a real deployment."
  type        = bool
  default     = true
}

# Networking
variable "vpc_cidr" {
  type = string
}

variable "azs" {
  type = list(string)
}

variable "single_nat_gateway" {
  type = bool
}

# ECS
variable "container_image" {
  type    = string
  default = "nginx:1.27-alpine"
}

variable "task_cpu" {
  type = number
}

variable "task_memory" {
  type = number
}

variable "desired_count" {
  type = number
}

variable "log_retention_days" {
  type = number
}

# RDS
variable "db_instance_class" {
  type = string
}

variable "db_allocated_storage" {
  type = number
}

variable "db_max_allocated_storage" {
  type = number
}

variable "db_multi_az" {
  type = bool
}

variable "db_backup_retention_period" {
  type = number
}

variable "db_deletion_protection" {
  type = bool
}

variable "db_skip_final_snapshot" {
  type = bool
}

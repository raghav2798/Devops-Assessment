variable "name" {
  description = "Name prefix (e.g. hotel-dev)."
  type        = string
}

variable "subnet_ids" {
  description = "Private subnet IDs for the DB subnet group."
  type        = list(string)
}

variable "security_group_id" {
  description = "RDS security group (only allows ingress from ECS)."
  type        = string
}

variable "db_name" {
  type    = string
  default = "hotel"
}

variable "username" {
  type    = string
  default = "app"
}

variable "engine_version" {
  description = "PostgreSQL version. A major-only value lets RDS pick the current default minor."
  type        = string
  default     = "16"
}

variable "instance_class" {
  type = string
}

variable "allocated_storage" {
  type = number
}

variable "max_allocated_storage" {
  description = "Upper bound for storage autoscaling."
  type        = number
}

variable "multi_az" {
  type    = bool
  default = false
}

variable "backup_retention_period" {
  description = "Days to keep automated backups (0-35)."
  type        = number
}

variable "deletion_protection" {
  type = bool
}

variable "skip_final_snapshot" {
  description = "Skip the final snapshot on destroy. Keep false whenever data matters."
  type        = bool
  default     = false
}

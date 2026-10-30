variable "name" {
  description = "Name prefix (e.g. hotel-dev). Keep short: ALB and target group names max 32 chars."
  type        = string
}

variable "vpc_id" {
  type = string
}

variable "public_subnet_ids" {
  description = "Subnets for the ALB."
  type        = list(string)
}

variable "private_subnet_ids" {
  description = "Subnets for the Fargate tasks."
  type        = list(string)
}

variable "alb_security_group_id" {
  type = string
}

variable "ecs_security_group_id" {
  type = string
}

variable "container_image" {
  description = "Placeholder app image. Swap for your own backend image."
  type        = string
  default     = "nginx:1.27-alpine"
}

variable "container_port" {
  type    = number
  default = 80
}

variable "health_check_path" {
  type    = string
  default = "/"
}

variable "task_cpu" {
  description = "Fargate CPU units (256, 512, 1024, ...)."
  type        = number
}

variable "task_memory" {
  description = "Fargate memory in MiB (must be a valid pair with task_cpu)."
  type        = number
}

variable "desired_count" {
  type = number
}

variable "log_retention_days" {
  type    = number
  default = 30
}

# Database wiring (from the rds module)
variable "db_host" {
  type = string
}

variable "db_port" {
  type = number
}

variable "db_name" {
  type = string
}

variable "db_secret_arn" {
  description = "Secrets Manager ARN containing the DB username/password JSON."
  type        = string
}

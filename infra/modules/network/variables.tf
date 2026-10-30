variable "name" {
  description = "Name prefix for all network resources (e.g. hotel-dev)."
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC."
  type        = string
}

variable "azs" {
  description = "Availability zones to spread subnets across (at least 2)."
  type        = list(string)

  validation {
    condition     = length(var.azs) >= 2
    error_message = "Provide at least two availability zones (ALB requires two)."
  }
}

variable "single_nat_gateway" {
  description = "Use one shared NAT gateway (cheaper, dev) instead of one per AZ (HA, prod)."
  type        = bool
  default     = false
}

variable "container_port" {
  description = "Port the application container listens on."
  type        = number
  default     = 80
}

variable "db_port" {
  description = "Port the database listens on."
  type        = number
  default     = 5432
}

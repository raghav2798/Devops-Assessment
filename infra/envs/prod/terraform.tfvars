environment = "prod"
region      = "ap-south-1"
plan_only   = true # set to false for a real deployment

# Network: NAT per AZ for HA across three zones
vpc_cidr           = "10.20.0.0/16"
azs                = ["ap-south-1a", "ap-south-1b", "ap-south-1c"]
single_nat_gateway = false

# ECS: two tasks across AZs
task_cpu           = 1024
task_memory        = 2048
desired_count      = 2
log_retention_days = 90

# RDS: larger, Multi-AZ, long retention, protected from deletion
db_instance_class          = "db.m6g.large"
db_allocated_storage       = 100
db_max_allocated_storage   = 500
db_multi_az                = true
db_backup_retention_period = 14
db_deletion_protection     = true
db_skip_final_snapshot     = false

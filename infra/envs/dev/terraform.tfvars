environment = "dev"
region      = "ap-south-1"
plan_only   = true # set to false for a real deployment

# Network: small and cheap
vpc_cidr           = "10.10.0.0/16"
azs                = ["ap-south-1a", "ap-south-1b"]
single_nat_gateway = true

# ECS: one small task
task_cpu           = 256
task_memory        = 512
desired_count      = 1
log_retention_days = 7

# RDS: smallest instance, short retention, easy teardown
db_instance_class          = "db.t4g.micro"
db_allocated_storage       = 20
db_max_allocated_storage   = 50
db_multi_az                = false
db_backup_retention_period = 1
db_deletion_protection     = false
db_skip_final_snapshot     = true

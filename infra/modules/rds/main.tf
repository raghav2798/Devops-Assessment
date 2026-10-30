resource "aws_db_subnet_group" "this" {
  name       = "${var.name}-db-subnets"
  subnet_ids = var.subnet_ids

  tags = { Name = "${var.name}-db-subnets" }
}

resource "aws_db_instance" "this" {
  identifier = "${var.name}-pg"

  engine         = "postgres"
  engine_version = var.engine_version
  instance_class = var.instance_class

  allocated_storage     = var.allocated_storage
  max_allocated_storage = var.max_allocated_storage
  storage_type          = "gp3"
  storage_encrypted     = true

  db_name  = var.db_name
  username = var.username
  # RDS generates the password and stores it in Secrets Manager, so it never lands in
  # Terraform state, tfvars or Git. ECS reads it at task start.
  manage_master_user_password = true

  db_subnet_group_name   = aws_db_subnet_group.this.name
  vpc_security_group_ids = [var.security_group_id]
  publicly_accessible    = false
  multi_az               = var.multi_az

  backup_retention_period = var.backup_retention_period
  backup_window           = "21:00-22:00"         # UTC, ~02:30 IST
  maintenance_window      = "sun:22:30-sun:23:30" # must not overlap backup_window

  deletion_protection       = var.deletion_protection
  skip_final_snapshot       = var.skip_final_snapshot
  final_snapshot_identifier = var.skip_final_snapshot ? null : "${var.name}-pg-final"

  auto_minor_version_upgrade = true

  tags = { Name = "${var.name}-pg" }
}

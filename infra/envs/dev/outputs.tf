output "alb_dns_name" {
  value = module.ecs.alb_dns_name
}

output "rds_endpoint" {
  value = module.rds.address
}

output "rds_secret_arn" {
  value = module.rds.master_secret_arn
}

output "rds_hostname" {
  description = "RDS instance hostname"
  value       = module.rds.rds_hostname
}

output "rds_port" {
  description = "RDS instance port"
  value       = module.rds.rds_port
}
output "rds_replica_hosts" {
  description = "RDS replica instance connection parameters"
  value       = module.rds.rds_replica_host
}

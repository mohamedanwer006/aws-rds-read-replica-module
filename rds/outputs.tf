output "rds_hostname" {
  description = "RDS instance hostname"
  value       = aws_db_instance.mysqldb.address
}

output "rds_port" {
  description = "RDS instance port"
  value       = aws_db_instance.mysqldb.port
}

output "rds_replica_host" {
  description = "RDS replica instance connection parameters"
  value       =  [ for i in aws_db_instance.replicas : i.address ] 
}



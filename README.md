# RDS Module 


How to use 

```terraform

module "rds" {
  source            = "./rds"
  identifier        = "mysqldb"
  region            = var.region
  vpc_id            = module.vpc.vpc_id
  db_username       = "admin"
  db_secret         = aws_kms_key.db_secret.key_id
  instance_class    = "db.t3.micro"
  allocated_storage = 5
  subnet_ids        = module.vpc.public_subnets
  engine            = "mysql"
  engine_version    = "8.0"
  readers_db_name = local.read_replicas
}

```

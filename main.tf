data "aws_availability_zones" "available" {}


module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.8.1"

  name                 = "myvpc"
  cidr                 = "10.0.0.0/16"
  azs                  = data.aws_availability_zones.available.names
  public_subnets       = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
  private_subnets      = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  enable_dns_hostnames = true
  enable_dns_support   = true
}

locals {
  read_replicas = toset(["reader1","reader2","reader3"])
}


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

resource "aws_kms_key" "db_secret" {
  description = "KMS Key"

}





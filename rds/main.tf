
resource "aws_db_subnet_group" "sub-group" {
  name       = "sub-group"
  subnet_ids = var.subnet_ids
  tags = {
    Name = "sub-group"
  }
}

resource "aws_security_group" "rds" {
  name   = "rds_sg"
  vpc_id = var.vpc_id

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]   # TODO: Ristrict for application IPs only - enhancement for Security  
  }

  egress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] 
  }

  tags = {
    Name = "rds"
  }
}


resource "aws_db_instance" "mysqldb" {
  identifier             = var.identifier
  instance_class         = var.instance_class
  allocated_storage      = var.allocated_storage
  engine                 = var.engine
  engine_version         = var.engine_version
  username               = var.db_username
  manage_master_user_password = true
  master_user_secret_kms_key_id = var.db_secret
  db_subnet_group_name   = aws_db_subnet_group.sub-group.name
  vpc_security_group_ids = [aws_security_group.rds.id]
  parameter_group_name   = "default.mysql8.0"
  publicly_accessible    = true
  skip_final_snapshot    = true
  # The days to retain backups for. Must be between 0 and 35.
  # Default is 0. Must be greater than 0 if the database is used as a source for a Read Replica
  backup_retention_period   = 1 
}


#  Creating Read Replicas
resource "aws_db_instance" "replicas" {
  for_each = toset(var.readers_db_name)
  replicate_source_db    = aws_db_instance.mysqldb.identifier
  identifier             = each.value
  instance_class         = var.instance_class
  db_subnet_group_name   = aws_db_subnet_group.sub-group.name
  vpc_security_group_ids = [aws_security_group.rds.id]
  parameter_group_name   = "default.mysql8.0"
  publicly_accessible    = true
  skip_final_snapshot    = true
}


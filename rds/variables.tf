
variable "vpc_id" {
  description = "VPC ID"
}

variable "region" {
  default     = "us-east-2"
  description = "AWS region"
}

variable "db_username" {
  default     = "mysql"
  description = "db name"
}

variable "instance_class" {
  default     = "db.t3.micro"
  description = "db instance class"
}

variable "allocated_storage" {
  default     = 5
  description = "db storage"
}

variable "identifier" {
  default     = "mysqldb"
  description = "db name"
}

variable "engine" {
  default     = "mysql"
  description = "engine"
}

variable "engine_version" {
  default     = "8.0"
  description = "engine version"
}
variable "subnet_ids" {
  description = "aws db subnet ids"
}

variable "db_secret" {
  description = "KMS secret key"
}

variable "readers_db_name" {
  description = "list of Readers"
}
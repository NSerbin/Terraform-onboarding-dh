variable "s3_bucket" {
  description = "s3 bucket configuration"
  type        = map(any)
}

variable "ec2" {
  description = "ec2 instance configuration"
  type        = map(any)
}

variable "db_rds" {
  description = "rds database configuration"
  type        = map(any)
}

variable "rds_sg" {
  description = "rds security group config"
  type        = map(any)
}

variable "ssh" {
  description = "Allow to ssh ec2 instances"
  type        = map(any)
}

variable "tags" {
  description = "tags for resources"
  type        = map(any)
}
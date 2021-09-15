variable "vpc" {
  description = "VPC Configuration"
  type        = map(any)
}


variable "alb" {
  description = "Application Load Balancer configuration"
  type        = map(any)
}

variable "asg_pg" {
  description = "Auto Scaling Placement Group configuration"
  type        = map(any)
}

variable "asg" {
  description = "Auto Scaling Group configuration "
  type        = map(any)
}

variable "asg_sg" {
  description = "Auto Scaling Group Security Group configuration "
  type        = map(any)
}

variable "s3_bucket" {
  description = "s3 bucket configuration"
  type        = map(any)
}

variable "cdn" {
  description = "Cloudflare configuration"
  type        = map(any)
}

variable "redis" {
  description = "ElastiCache REDIS configuration configuration"
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

variable "alb_sg" {
  description = "Application Load Balancer security group config"
  type        = map(any)
}

variable "tags" {
  description = "tags for resources"
  type        = map(any)
  default     = {}
}

variable "label" {
  description = "Labels for resources"
  type        = map(any)
}
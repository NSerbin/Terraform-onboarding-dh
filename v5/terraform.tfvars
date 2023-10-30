vpc = {
  cidr_block       = "10.200.0.0/24"
  private_subnet_1 = "10.200.0.128/26"
  private_subnet_2 = "10.200.0.192/26"
  az_1             = "us-east-1a"
  az_2             = "us-east-1c"
}

alb = {
  name                       = "obn-devops-nserbin-sbx-alb"
  internal                   = "false"
  load_balancer_type         = "application"
  enable_deletion_protection = "false"
}

alb_sg = {
  name        = "alb-security-group"
  description = "allow inbound and outbound access to the Load Balancer"
}

asg_pg = {
  name     = "obn_devops_nserbin_sbx_pg"
  strategy = "spread"
}

asg = {
  name_prefix               = "obn_devops_nserbin_sbx_asg_template"
  image_id                  = "ami-087c17d1fe0178315"
  instance_type             = "t3.micro"
  desired_capacity          = 2
  max_size                  = 10
  min_size                  = 2
  health_check_grace_period = 300
  health_check_type         = "ELB"
  name                      = "obn_devops_nserbin_asg_policy"
  predefined_metric_type    = "ASGAverageCPUUtilization"
  target_value              = 1.0
  policy_type               = "TargetTrackingScaling"
  key_name                  = "onboarding-nserbin-terra"
}

asg_sg = {
  name        = "asg-security-group"
  description = "allow inbound access to the database"
}

s3_bucket = {
  bucket = "obn-devops-nserbin-sbx-bucket"
  acl    = "private"
}

cdn = {
  s3_origin_id           = "obn_devops_nserbin_sbx_cdn_origin"
  origin_access_identity = "obn_devops_nserbin_sbx_cdn_origin"
  enabled                = "true"
  is_ipv6_enabled        = "true"
}

redis = {
  cluster_id           = "obn-devops-nserbin-sbx-redis"
  engine               = "redis"
  node_type            = "cache.t3.micro"
  num_cache_nodes      = 1
  parameter_group_name = "default.redis3.2"
  engine_version       = "3.2.10"
  port                 = 6379
}

db_rds = {
  storage              = 10
  engine               = "mysql"
  engine_ver           = "5.7"
  instance_class       = "db.t3.micro"
  name                 = "mydb"
  username             = "onboarding"
  password             = "nserbinv5"
  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot  = "true"
  port                 = 3306
}

rds_sg = {
  name        = "rds-security-group"
  description = "allow inbound access to the database"
}

tags = {
  name      = "digitalhouse"
  project   = "core"
  stage     = "qa"
  prefix    = "qa"
  territory = "latam"
  namespace = "dh"
  vertical  = "gbl"
  delimiter = "-"
  squad     = "devops"
  id        = "onboarding"
}

label = {
  id          = "obn_devops_nserbin_sbx"
  enabled     = true
  namespace   = "obn"
  name        = "devops"
  stage       = "sbx"
  environment = "nserbin"
  delimiter   = "-"
  attributes  = "private"
}
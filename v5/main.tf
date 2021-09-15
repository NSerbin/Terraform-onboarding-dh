resource "aws_vpc" "obn_devops_nserbin_sbx_vpc" {
  cidr_block = var.vpc["cidr_block"]

  tags = {
    vertical = var.tags["vertical"]
    squad    = var.tags["squad"]
    project  = var.tags["project"]
    stage    = var.tags["stage"]
  }
}

resource "aws_subnet" "obn_devops_nserbin_subnet_1" {
  vpc_id            = aws_vpc.obn_devops_nserbin_sbx_vpc.id
  cidr_block        = var.vpc["private_subnet_1"]
  availability_zone = var.vpc["az_1"]

  tags = {
    vertical = var.tags["vertical"]
    squad    = var.tags["squad"]
    project  = var.tags["project"]
    stage    = var.tags["stage"]
  }
}

resource "aws_subnet" "obn_devops_nserbin_subnet_2" {
  vpc_id            = aws_vpc.obn_devops_nserbin_sbx_vpc.id
  cidr_block        = var.vpc["private_subnet_2"]
  availability_zone = var.vpc["az_2"]

  tags = {
    vertical = var.tags["vertical"]
    squad    = var.tags["squad"]
    project  = var.tags["project"]
    stage    = var.tags["stage"]
  }
}

resource "aws_internet_gateway" "obn_devops_nserbin_gateway" {
  vpc_id = aws_vpc.obn_devops_nserbin_sbx_vpc.id

  tags = {
    vertical = var.tags["vertical"]
    squad    = var.tags["squad"]
    project  = var.tags["project"]
    stage    = var.tags["stage"]
  }
}

resource "aws_lb" "obn_devops_nserbin_sbx_alb" {
  name               = var.alb["name"]
  internal           = var.alb["internal"]
  load_balancer_type = var.alb["load_balancer_type"]
  security_groups    = [aws_security_group.obn_devops_nserbin_sbx_alb_sg.id]
  subnets            = [aws_subnet.obn_devops_nserbin_subnet_1.id, aws_subnet.obn_devops_nserbin_subnet_2.id]

  enable_deletion_protection = var.alb["enable_deletion_protection"]

  tags = {
    vertical = var.tags["vertical"]
    squad    = var.tags["squad"]
    project  = var.tags["project"]
    stage    = var.tags["stage"]
  }
}

resource "aws_security_group" "obn_devops_nserbin_sbx_alb_sg" {
  name        = var.alb_sg["name"]
  description = var.alb_sg["description"]
  vpc_id      = aws_vpc.obn_devops_nserbin_sbx_vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    vertical = var.tags["vertical"]
    squad    = var.tags["squad"]
    project  = var.tags["project"]
    stage    = var.tags["stage"]
  }
}

resource "aws_placement_group" "obn_devops_nserbin_sbx_asg_pg" {
  name     = var.asg_pg["name"]
  strategy = var.asg_pg["strategy"]
}

resource "aws_launch_template" "obn_devops_nserbin_sbx_asg_template" {
  name_prefix   = var.asg["name_prefix"]
  image_id      = var.asg["image_id"]
  instance_type = var.asg["instance_type"]
  user_data     = filebase64("template/alb_userdata.sh")

  tags = {
    vertical = var.tags["vertical"]
    squad    = var.tags["squad"]
    project  = var.tags["project"]
    stage    = var.tags["stage"]
  }
}

resource "aws_autoscaling_group" "obn_devops_nserbin_sbx_asg" {
  availability_zones        = ["us-east-1a"]
  desired_capacity          = var.asg["desired_capacity"]
  max_size                  = var.asg["max_size"]
  min_size                  = var.asg["min_size"]
  health_check_grace_period = var.asg["health_check_grace_period"]
  health_check_type         = var.asg["health_check_type"]
  placement_group           = aws_placement_group.obn_devops_nserbin_sbx_asg_pg.id

  launch_template {
    id      = aws_launch_template.obn_devops_nserbin_sbx_asg_template.id
    version = "$Latest"
  }
}

resource "aws_security_group" "obn_devops_nserbin_sbx_asg_sg" {
  name        = var.asg_sg["name"]
  description = var.asg_sg["description"]
  vpc_id      = aws_vpc.obn_devops_nserbin_sbx_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    vertical = var.tags["vertical"]
    squad    = var.tags["squad"]
    project  = var.tags["project"]
    stage    = var.tags["stage"]
  }
}

resource "aws_autoscaling_policy" "obn_devops_nserbin_asg_policy" {
  name                   = var.asg["name"]
  autoscaling_group_name = aws_autoscaling_group.obn_devops_nserbin_sbx_asg.name
  policy_type            = var.asg["policy_type"]
  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = var.asg["predefined_metric_type"]
    }

    target_value = var.asg["target_value"]
  }
}

locals {
  s3_origin_id = var.cdn["s3_origin_id"]
}

resource "aws_cloudfront_origin_access_identity" "obn_devops_nserbin_sbx_cdn_access" {
  comment = "CloudFront ID"
}
resource "aws_cloudfront_distribution" "obn_devops_nserbin_sbx_cdn" {
  origin {
    domain_name = aws_s3_bucket.obn_devops_nserbin_sbx_bucket.bucket_regional_domain_name
    origin_id   = local.s3_origin_id

    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.obn_devops_nserbin_sbx_cdn_access.cloudfront_access_identity_path
    }
  }

  enabled         = var.cdn["enabled"]
  is_ipv6_enabled = var.cdn["is_ipv6_enabled"]

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = local.s3_origin_id

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "allow-all"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }

  price_class = "PriceClass_All"

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  tags = {
    vertical = var.tags["vertical"]
    squad    = var.tags["squad"]
    project  = var.tags["project"]
    stage    = var.tags["stage"]
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }
}
resource "aws_s3_bucket" "obn_devops_nserbin_sbx_bucket" {
  bucket = var.s3_bucket["bucket"]
  acl    = var.s3_bucket["acl"]

  tags = {
    vertical = var.tags["vertical"]
    squad    = var.tags["squad"]
    project  = var.tags["project"]
    stage    = var.tags["stage"]
  }
}

resource "aws_s3_bucket_policy" "obn_devops_nserbin_sbx_bucket_policy" {
  bucket = aws_s3_bucket.obn_devops_nserbin_sbx_bucket.id
  policy = data.template_file.obn_devops_nserbin_sbx_iam_s3_bucket_policy.rendered
}

data "template_file" "obn_devops_nserbin_sbx_iam_s3_bucket_policy" {
  template = file("template/s3_bucket_policy.json")

  vars = {
    bucket_name = "obn-devops-nserbin-sbx-bucket"
  }
}

data "aws_iam_policy_document" "s3_policy" {
  statement {
    actions   = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.obn_devops_nserbin_sbx_bucket.arn}/*"]

    principals {
      type        = "AWS"
      identifiers = [aws_cloudfront_origin_access_identity.obn_devops_nserbin_sbx_cdn_access.iam_arn]
    }
  }
}

module "obn_devops_nserbin_sbx_redis" {
  source                     = ""
  availability_zones         = ["us-east-1a", "us-east-1b"]
  name                       = var.label["name"]
  vpc_id                     = aws_vpc.obn_devops_nserbin_sbx_vpc.id
  allowed_security_groups    = [aws_security_group.obn_devops_nserbin_sbx_asg_sg.id]
  subnets                    = [aws_subnet.obn_devops_nserbin_subnet_1.id, aws_subnet.obn_devops_nserbin_subnet_2.id]
  cluster_size               = var.redis["num_cache_nodes"]
  instance_type              = var.redis["node_type"]
  apply_immediately          = true
  automatic_failover_enabled = false
  engine_version             = var.redis["engine_version"]
}

module "obn_devops_nserbin_sbx_rds_mysql" {
  source              = ""
  vpc_id              = aws_vpc.obn_devops_nserbin_sbx_vpc.id
  skip_final_snapshot = var.db_rds["skip_final_snapshot"]
  engine_version      = var.db_rds["engine_ver"]
  engine              = var.db_rds["engine"]
  database_name       = var.db_rds["name"]
  database_user       = var.db_rds["username"]
  database_password   = var.db_rds["password"]
  database_port       = var.db_rds["port"]
  allocated_storage   = var.db_rds["storage"]
  instance_class      = var.db_rds["instance_class"]
  db_parameter_group  = var.db_rds["parameter_group_name"]
  subnet_ids          = [aws_subnet.obn_devops_nserbin_subnet_1.id, aws_subnet.obn_devops_nserbin_subnet_2.id]
  security_group_ids  = [aws_security_group.obn_devops_nserbin_sbx_rds_sg.id]

  tags = {
    vertical = var.tags["vertical"]
    squad    = var.tags["squad"]
    project  = var.tags["project"]
    stage    = var.tags["stage"]
  }
}

resource "aws_security_group" "obn_devops_nserbin_sbx_rds_sg" {
  name        = var.rds_sg["name"]
  description = var.rds_sg["description"]
  vpc_id      = aws_vpc.obn_devops_nserbin_sbx_vpc.id

  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    description     = "Keep the instance private by only allowing traffic from the application"
    security_groups = [aws_security_group.obn_devops_nserbin_sbx_asg_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    description = "Allow outbound traffic only to localhost"
    cidr_blocks = ["127.0.0.1/32"]
  }

  tags = {
    vertical = var.tags["vertical"]
    squad    = var.tags["squad"]
    project  = var.tags["project"]
    stage    = var.tags["stage"]
  }
}

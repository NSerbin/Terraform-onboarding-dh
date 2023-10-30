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

resource "aws_instance" "obn_devops_nserbin_sbx_ec2" {
  count         = var.ec2["count"]
  ami           = var.ec2["ami"]
  subnet_id     = var.ec2["subnet_id"]
  instance_type = var.ec2["instance_type"]
  key_name      = var.ec2["key_name"]

  tags = {
    vertical = var.tags["vertical"]
    squad    = var.tags["squad"]
    project  = var.tags["project"]
    stage    = var.tags["stage"]
  }
}

resource "aws_security_group" "obn_devops_nserbin_sbx_ec2_sg" {
  name        = var.ssh["name"]
  description = var.ssh["description"]
  vpc_id      = var.ssh["vpc_id"]

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

resource "aws_db_instance" "obn_devops_nserbin_sbx_db" {
  allocated_storage      = var.db_rds["storage"]
  engine                 = var.db_rds["engine"]
  engine_version         = var.db_rds["engine_ver"]
  instance_class         = var.db_rds["instance_class"]
  name                   = var.db_rds["name"]
  username               = var.db_rds["username"]
  password               = var.db_rds["password"]
  parameter_group_name   = var.db_rds["parameter_group_name"]
  skip_final_snapshot    = var.db_rds["skip_final_snapshot"]
  vpc_security_group_ids = [aws_security_group.obn_devops_nserbin_sbx_rds_sg.id]
}

resource "aws_security_group" "obn_devops_nserbin_sbx_rds_sg" {
  name        = var.rds_sg["name"]
  description = var.rds_sg["description"]
  vpc_id      = var.rds_sg["vpc_id"]

  ingress {
    protocol        = "tcp"
    from_port       = 3306
    to_port         = 3306
    security_groups = ["aws_security_group.obn_devops_nserbin_sbx_ec2_sg.id"]
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    vertical = var.tags["vertical"]
    squad    = var.tags["squad"]
    project  = var.tags["project"]
    stage    = var.tags["stage"]
  }
}

data "template_file" "obn_devops_nserbin_sbx_iam_s3_bucket_policy" {
  template = file("template/s3_bucket_policy.json")

  vars = {
    bucket_name = "obn_devops_nserbin_sbx"
  }
}


resource "aws_s3_bucket" "onboarding_terra_v2" {
  bucket = "onboarding-terra-v2"
  acl    = "private"

  tags = {
    Name  = "onboarding-terra2"
    Owner = "Nserbin"
  }
}

resource "aws_s3_bucket_policy" "onboarding_terra_v2" {
  bucket = aws_s3_bucket.onboarding_terra_v2.id

  policy = jsonencode({
    Version = "2012-10-17"
    Id      = "onboarding-terra-v2"
    Statement = [
      {
        Sid    = "onboarding-terra-v2"
        Action = "s3:*"
        Effect = "Allow"
        Resource = [aws_s3_bucket.onboarding_terra_v2.arn,
          "${aws_s3_bucket.onboarding_terra_v2.arn}/*",
        ]
        Principal = "*"
      }
    ]

  })
}

resource "aws_instance" "onboarding_terra_v2" {
  count         = 2
  ami           = "ami-087c17d1fe0178315"
  subnet_id     = "subnet-d220fab4"
  instance_type = "t2.micro"
  key_name      = "onboarding-nserbin-terra"

  tags = {
    Name  = "onboarding-terra2"
    Owner = "Nserbin"
  }
}

resource "aws_security_group" "allowterra_ssh" {
  name        = "allowterra_ssh"
  description = "Allow SSH"
  vpc_id      = "vpc-e917e194"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    description = "Allow SSH"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    description = "Allow outbound traffic"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name  = "onboarding-terra2"
    Owner = "Nserbin"
  }
}

resource "aws_db_instance" "onboarding-terra-v2" {
  allocated_storage      = 10
  engine                 = "mysql"
  engine_version         = "5.7"
  instance_class         = "db.m5.large"
  name                   = "mydb"
  username               = "onboarding"
  password               = "nserbinv2"
  parameter_group_name   = "default.mysql5.7"
  skip_final_snapshot    = true
  vpc_security_group_ids = [aws_security_group.rds-sg.id]
}

resource "aws_security_group" "rds-sg" {
  name        = "rds-security-group"
  description = "allow inbound access to the database"
  vpc_id      = "vpc-e917e194"

  ingress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name  = "onboarding-terra2"
    Owner = "Nserbin"
  }
}
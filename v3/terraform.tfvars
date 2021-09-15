ec2 = {
  count         = 2
  ami           = "ami-087c17d1fe0178315"
  subnet_id     = "subnet-d220fab4"
  instance_type = "t2.micro"
  key_name      = "onboarding-nserbin-terra"
}

db_rds = {
  storage              = 10
  engine               = "mysql"
  engine_ver           = "5.7"
  instance_class       = "db.t3.micro"
  name                 = "mydb"
  username             = "onboarding"
  password             = "nserbinv3"
  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot  = "true"
}

rds_sg = {
  name        = "rds-security-group"
  description = "allow inbound access to the database"
  vpc_id      = "vpc-e917e194"
}

ssh = {
  name        = "allow_ssh"
  description = "Allow SSH"
  vpc_id      = "vpc-e917e194"
}

tags = {
  vertical = "obn"
  squad    = "devops"
  project  = "nserbin"
  stage    = "sbx"
}

s3_bucket = {
  bucket = "obn-devops-nserbin-sbx"
  acl    = "private"
}
resource "aws_instance" "onboarding_terra_v1" {
  ami           = "ami-087c17d1fe0178315"
  subnet_id     = "subnet-d220fab4"
  instance_type = "t3.micro"
  key_name      = "onboarding-nserbin-terra"
  tags = {
    Name  = "onboarding-terrav1"
    Owner = "Nserbin"
  }
}

resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
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
    Name  = "onboarding-terrav1"
    Owner = "Nserbin"
  }
}
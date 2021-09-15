terraform {
  backend "s3" {
    bucket         = "onboardingterrav3"
    key            = "state/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-lock"
  }
}
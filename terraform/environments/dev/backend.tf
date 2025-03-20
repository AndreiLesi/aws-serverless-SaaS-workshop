# Disabled, we are not using the terraform backend
#terraform {
#  backend "s3" {
#    region         = "eu-central-1"
#    bucket         = "serverless-saas-dev-terraform-state"
#    key            = "terraform.tfstate"
#    encrypt        = true
#    dynamodb_table = "serverless-saas-dev-terraform-state-lock"
#  }
#}

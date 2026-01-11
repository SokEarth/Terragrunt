locals {
  project = "startup"
  region = "eu-west-1"
  account_id = "023520667418"
} 

remote_state {
  backend = "s3"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite"
  }
  config = {
    bucket         = "tf-state-${local.account_id}"
    region         = "us-east-1"
    key            = "${path_relative_to_include()}/terraform.tfstate"
    dynamodb_table = "terraform_locks"
    encrypt        = true
  }
}
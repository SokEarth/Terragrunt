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
    bucket         = "tf-state-awesome"
    region         = "eu-west-1"
    key            = "${path_relative_to_include()}/terraform.tfstate"
    use_lockfile   = true
    encrypt        = true
  }
}
locals {
  project = "startup"
  region = "eu-west-1"
  account_id = "023520667418"
} 

remote_state {
  backend = "s3"
  generate "provider" {
  path      = "backend.tf"
  if_exists = "overwrite"
  contents  = <<EOF
provider "aws" {
  region = "${local.region}"
  assume_role {
    role_arn = "arn:aws:iam::${local.account_id}:role/TerraformRole"
  }
}
EOF
}
  config = {
    bucket         = "tf-state-${local.account_id}"
    key            = "${path_relative_to_include()}/terraform.tfstate"
    region         = local.region
    use_lockfile   = true
    encrypt        = true
  }
}

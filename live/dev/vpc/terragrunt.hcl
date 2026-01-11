terraform {
  source = "../../../infra/modules/vpc"
}

include {
  path = "../../root.hcl"
  expose = true
}

locals {
  env = read_terragrunt_config("../env.hcl")
}

inputs = {
  env = local.env.locals.env
  name = "${include.locals.project}-${local.env.locals.env}-vpc"
  azs             = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
  private_subnet_tags = {
    "kubernetes.io/role/internal-elb" = 1
    "kubernetes.io/cluster/dev"  = "owned"
  }

  public_subnet_tags = {
    "kubernetes.io/role/elb"         = 1
    "kubernetes.io/cluster/dev" = "owned"
  }
}
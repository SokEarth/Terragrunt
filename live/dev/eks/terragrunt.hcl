terraform {
  source = "../../../infra/modules/eks"
}

include {
  path = "../../root.hcl"
  expose = true
}

locals {
  env = read_terragrunt_config("../env.hcl")
}

dependency "vpc" {
  config_path = "../vpc"

  mock_outputs = {
    private_subnet_ids = ["subnet-a", "subnet-b"]
  }
}

inputs = {
  eks_version = "1.34"
  env         = local.env.locals.env
  eks_name    = "${include.locals.project}-${local.env.locals.env}-eks"
  region      = include.locals.region
  subnet_ids  = dependency.vpc.outputs.private_subnet_ids

  node_groups = {
    general = {
      capacity_type  = "ON_DEMAND"
      instance_types = ["t3.medium"]
      scaling_config = {
        desired_size = 3
        max_size     = 4
        min_size     = 2
      }
    }
  }
}

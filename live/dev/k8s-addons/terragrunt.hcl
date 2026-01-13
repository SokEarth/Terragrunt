terraform {
  source = "../../../infra/modules/k8s-addons"
}

include {
  path = "../../root.hcl"
  expose = true
}

locals {
  env = read_terragrunt_config("../env.hcl")
}

dependency "eks" {
  config_path = "../eks"
}

inputs = {
  env         = local.env.locals.env
  eks_name    = dependency.eks.outputs.eks_name
  region      = include.locals.region
  openid_provider_arn = dependency.eks.outputs.openid_provider_arn
  node_role_arn = dependency.eks.outputs.node_role_arn
}
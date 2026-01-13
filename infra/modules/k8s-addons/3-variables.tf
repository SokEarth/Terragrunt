variable "eks_name" {
  description = "Name of the cluster."
  type        = string
}

variable "region" {
  description = "Region of the cluster."
  type        = string
}

variable "openid_provider_arn" {
  description = "Cluster OIDC."
  type        = string
}

variable "node_role_arn" {
  description = "Node role arn."
  type        = string
}
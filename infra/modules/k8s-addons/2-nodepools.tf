# EC2NodeClass (shared)

resource "kubernetes_manifest" "default_nodeclass" {
  depends_on = [null_resource.wait_for_karpenter_crds]
  manifest = {
    apiVersion = "karpenter.k8s.aws/v1beta1"
    kind       = "EC2NodeClass"
    metadata = { name = "default" }
    spec = {
      role = var.node_role_arn

      # REQUIRED: select the AMI family
      amiFamily = "AL2"

      # REQUIRED: select security groups
      securityGroupSelectorTerms = [
        {
          tags = {
            "kubernetes.io/cluster/${var.eks_name}" = "owned"
          }
        }
      ]

      subnetSelectorTerms = [
        {
          tags = {
            "kubernetes.io/cluster/${var.eks_name}" = "owned"
          }
        }
      ]
    }
  }
}

#x86 NodePool
resource "kubernetes_manifest" "amd64_pool" {
  depends_on = [null_resource.wait_for_karpenter_crds]
  manifest = {
    apiVersion = "karpenter.sh/v1beta1"
    kind       = "NodePool"
    metadata = { name = "amd64" }
    spec = {
      template = {
        spec = {
          nodeClassRef = { name = "default" }
          requirements = [
            {
              key      = "kubernetes.io/arch"
              operator = "In"
              values   = ["amd64"]
            },
            {
              key      = "karpenter.sh/capacity-type"
              operator = "In"
              values   = ["spot", "on-demand"]
            }
          ]
        }
      }
    }
  }
}

# arm64 (Graviton) NodePool
resource "kubernetes_manifest" "arm64_pool" {
  depends_on = [null_resource.wait_for_karpenter_crds]
  manifest = {
    apiVersion = "karpenter.sh/v1beta1"
    kind       = "NodePool"
    metadata = { name = "arm64" }
    spec = {
      template = {
        spec = {
          nodeClassRef = { name = "default" }
          requirements = [
            {
              key      = "kubernetes.io/arch"
              operator = "In"
              values   = ["arm64"]
            },
            {
              key      = "karpenter.sh/capacity-type"
              operator = "In"
              values   = ["spot", "on-demand"]
            }
          ]
        }
      }
    }
  }
}
# EC2NodeClass (shared)

resource "kubernetes_manifest" "default_nodeclass" {
  manifest = {
    apiVersion = "karpenter.k8s.aws/v1beta1"
    kind       = "EC2NodeClass"
    metadata = { name = "default" }
    spec = {
      role = aws_iam_role.nodes.arn

      # REQUIRED: select the AMI family
      amiFamily = "AL2"

      # REQUIRED: select security groups
      securityGroupSelectorTerms = [
        {
          tags = {
            "kubernetes.io/cluster/${aws_eks_cluster.this.name}" = "owned"
          }
        }
      ]

      subnetSelectorTerms = [
        {
          tags = {
            "kubernetes.io/cluster/${aws_eks_cluster.this.name}" = "owned"
          }
        }
      ]
    }
  }
}

#x86 NodePool
resource "kubernetes_manifest" "amd64_pool" {
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
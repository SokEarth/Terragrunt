data "aws_eks_cluster_auth" "this" {
  depends_on = [aws_eks_cluster.this]
  name = aws_eks_cluster.this.name
}

provider "kubernetes" {
  host = data.aws_eks_cluster.this.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.this.certificate_authority[0].data)
  token = data.aws_eks_cluster_auth.this.token
}

resource "aws_eks_access_entry" "admin" {
  cluster_name = aws_eks_cluster.this.name
  principal_arn = "arn:aws:iam::023520667418:user/deployer"
  type = "STANDARD"
}

resource "aws_eks_access_policy_association" "admin_policy" {
  cluster_name = aws_eks_access_entry.admin.cluster_name
  principal_arn = aws_eks_access_entry.admin.principal_arn
  policy_arn = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"

  access_scope {
    type = "cluster"
  }
}

resource "aws_eks_cluster" "this" {
  name     = var.cluster_name
  role_arn = aws_iam_role.cluster.arn

  vpc_config {
    subnet_ids              = var.subnet_ids
    endpoint_public_access  = false
    endpoint_private_access = true
    security_group_ids      = var.security_group_ids
  }

  enabled_cluster_log_types = [
    "api",
    "audit",
    "authenticator",
    "controllerManager",
    "scheduler"
  ]

  encryption_config {
    resources = ["secrets"]
    provider {
      key_arn = aws_kms_key.eks.arn
    }
  }

  tags = var.tags
}

resource "aws_kms_key" "eks" {
  description             = "EKS Secret Encryption Key"
  enable_key_rotation     = true # Fixes AVD-AWS-0065
  deletion_window_in_days = 7
}

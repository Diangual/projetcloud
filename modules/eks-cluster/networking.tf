resource "aws_security_group" "eks" {
  name_prefix = "${var.cluster_name}-sg"
  vpc_id      = var.vpc_id
  description = "Security group for EKS cluster ${var.cluster_name}"
}

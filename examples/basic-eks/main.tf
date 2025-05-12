module "eks_cluster" {
  source = "../../modules/eks-cluster"

  cluster_name       = "my-test-cluster"
  vpc_id             = "vpc-08d2584a4e90f2085"
  subnet_ids         = ["subnet-031e4339c339c7888", "subnet-02036243b3d194e1a", "subnet-0d9a38d6a5ed2b0d1"]
  security_group_ids = ["sg-05f5311fdee8d093a"]
}

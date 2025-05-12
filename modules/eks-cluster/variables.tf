variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID where the cluster will be deployed"
  type        = string
  default     = "vpc-08d2584a4e90f2085"
}

variable "subnet_ids" {
  type        = list(string)
  description = "List of subnet IDs for EKS cluster"
}

variable "tags" {
  type        = map(string)
  description = "A map of tags to apply to EKS cluster resources"
  default     = {} # Makes it optional (no tags if not provided)
}

variable "security_group_ids" {
  type        = list(string)
  description = "VPC security group"
}

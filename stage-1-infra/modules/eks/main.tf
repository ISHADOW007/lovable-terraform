resource "aws_eks_cluster" "this" {

  name     = var.cluster_name
  role_arn = var.cluster_role_arn

  version = "1.33"

  vpc_config {

    subnet_ids = var.subnet_ids

    security_group_ids = [
      var.cluster_security_group_id
    ]

    endpoint_private_access = true
    endpoint_public_access  = true
  }

  access_config {
    authentication_mode                         = "API_AND_CONFIG_MAP"
    bootstrap_cluster_creator_admin_permissions = true
  }

  tags = var.tags
}








resource "aws_eks_node_group" "this" {

  cluster_name    = aws_eks_cluster.this.name
  node_group_name = var.node_group_name
  node_role_arn   = var.node_role_arn

  subnet_ids = var.subnet_ids

  instance_types = var.instance_types

  scaling_config {
    desired_size = var.desired_size
    min_size     = var.min_size
    max_size     = var.max_size
  }

  update_config {
    max_unavailable = 1
  }

  ami_type       = "AL2023_x86_64_STANDARD"
  capacity_type  = "ON_DEMAND"
  disk_size      = 20

  depends_on = [
    aws_eks_cluster.this
  ]

  tags = var.tags
}
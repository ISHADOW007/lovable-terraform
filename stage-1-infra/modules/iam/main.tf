############################
# EKS Cluster IAM Role
############################

resource "aws_iam_role" "eks_cluster" {

  name = "lovable-eks-cluster-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Principal = {
          Service = "eks.amazonaws.com"
        }

        Action = "sts:AssumeRole"
      }
    ]
  })

  tags = var.common_tags
}

############################
# Attach AWS Managed Policies
############################

resource "aws_iam_role_policy_attachment" "cluster_policy" {

  role = aws_iam_role.eks_cluster.name

  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}


############################
# Worker Node IAM Role
############################

resource "aws_iam_role" "node_group" {

  name = "lovable-eks-node-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Principal = {
          Service = "ec2.amazonaws.com"
        }

        Action = "sts:AssumeRole"
      }
    ]
  })

  tags = var.common_tags
}


resource "aws_iam_role_policy_attachment" "worker_node" {

  role = aws_iam_role.node_group.name

  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
}

resource "aws_iam_role_policy_attachment" "cni" {

  role = aws_iam_role.node_group.name

  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
}

resource "aws_iam_role_policy_attachment" "ecr" {

  role = aws_iam_role.node_group.name

  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}
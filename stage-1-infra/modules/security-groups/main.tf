############################
# EKS Cluster Security Group
############################

resource "aws_security_group" "eks_cluster" {
  name        = "lovable-eks-cluster-sg"
  description = "Security Group for EKS Control Plane"
  vpc_id      = var.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    var.common_tags,
    {
      Name = "lovable-eks-cluster-sg"
    }
  )
}

############################
# Worker Node Security Group
############################

resource "aws_security_group" "worker_nodes" {
  name        = "lovable-worker-node-sg"
  description = "Security Group for Worker Nodes"
  vpc_id      = var.vpc_id

  # Nodes communicate with each other
  ingress {
    description = "Node to Node"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    self        = true
  }

  # Control plane -> Nodes
  ingress {
    description     = "Cluster to Nodes"
    from_port       = 1025
    to_port         = 65535
    protocol        = "tcp"
    security_groups = [aws_security_group.eks_cluster.id]
  }

  # SSH (optional for debugging)
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    var.common_tags,
    {
      Name = "lovable-worker-node-sg"
    }
  )
}

############################
# Worker Nodes -> Cluster API
############################

resource "aws_security_group_rule" "worker_to_cluster" {
  type                     = "ingress"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  security_group_id        = aws_security_group.eks_cluster.id
  source_security_group_id = aws_security_group.worker_nodes.id
}
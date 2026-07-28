##############################################
# AWS
##############################################

provider "aws" {

  region = data.terraform_remote_state.infra.outputs.region

}

##############################################
# EKS Cluster
##############################################

data "aws_eks_cluster" "this" {

  name = data.terraform_remote_state.infra.outputs.cluster_name

}

data "aws_eks_cluster_auth" "this" {

  name = data.aws_eks_cluster.this.name

}

##############################################
# Kubernetes Provider
##############################################

provider "kubernetes" {

  host = data.aws_eks_cluster.this.endpoint

  cluster_ca_certificate = base64decode(
    data.aws_eks_cluster.this.certificate_authority[0].data
  )

  token = data.aws_eks_cluster_auth.this.token

}

##############################################
# Helm Provider
##############################################

provider "helm" {

  kubernetes = {

    host = data.aws_eks_cluster.this.endpoint

    cluster_ca_certificate = base64decode(
      data.aws_eks_cluster.this.certificate_authority[0].data
    )

    token = data.aws_eks_cluster_auth.this.token

  }

}
module "vpc" {

  source = "./modules/vpc"

  vpc_name = var.vpc_name
  vpc_cidr = var.vpc_cidr

  public_subnet_1_cidr = var.public_subnet_1_cidr
  public_subnet_2_cidr = var.public_subnet_2_cidr

  private_subnet_1_cidr = var.private_subnet_1_cidr
  private_subnet_2_cidr = var.private_subnet_2_cidr

  availability_zone_1 = var.availability_zone_1
  availability_zone_2 = var.availability_zone_2

  common_tags = local.common_tags
}




module "nat_instance" {

  source = "./modules/nat-instance"

  vpc_id   = module.vpc.vpc_id
  vpc_cidr = var.vpc_cidr

  public_subnet_id = module.vpc.public_subnet_1_id

  private_route_table_id = module.vpc.private_route_table_id

  key_name = var.key_name

  instance_type = "t3.micro"

  common_tags = local.common_tags
}


module "iam" {

  source = "./modules/iam"

  common_tags = local.common_tags
}




module "security_groups" {
  source = "./modules/security-groups"

  vpc_id = module.vpc.vpc_id

  common_tags = local.common_tags
}


module "eks" {

  source = "./modules/eks"

  cluster_name = "lovable-cluster"

  cluster_role_arn = module.iam.cluster_role_arn
  node_role_arn    = module.iam.node_role_arn

  subnet_ids = [
    module.vpc.private_subnet_1_id,
    module.vpc.private_subnet_2_id
  ]

  cluster_security_group_id = module.security_groups.cluster_security_group_id

  worker_security_group_id = module.security_groups.worker_security_group_id

  node_security_group_id = module.security_groups.worker_security_group_id

  node_group_name = "lovable-cluster-nodes"

  instance_types = ["c7i-flex.large"]

  desired_size = 2
  min_size     = 2
  max_size     = 28

  tags = local.common_tags
}


module "oidc" {
  source = "./modules/oidc"

  cluster_oidc_issuer_url = module.eks.oidc_issuer_url
}




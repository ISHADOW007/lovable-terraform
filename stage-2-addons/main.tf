






data "terraform_remote_state" "infra" {
  backend = "s3"

  config = {
    bucket = "lovable-terraform-state-457724887427"
    key    = "stage-1-network/terraform.tfstate"
    region = "ap-south-1"
  }
}




module "external_secrets_operator" {

  source = "./modules/external-secrets-operator"

  cluster_name = data.terraform_remote_state.infra.outputs.cluster_name

  region = var.aws_region

  oidc_provider_arn = data.terraform_remote_state.infra.outputs.oidc_provider_arn

  oidc_provider_url = "https://${data.terraform_remote_state.infra.outputs.oidc_issuer_url}"

  namespace = "external-secrets"

}









module "aws_load_balancer_controller" {
  source = "./modules/aws-load-balancer-controller"

  cluster_name            = data.terraform_remote_state.infra.outputs.cluster_name
  cluster_oidc_issuer_url = data.terraform_remote_state.infra.outputs.oidc_issuer_url

  oidc_provider_arn = data.terraform_remote_state.infra.outputs.oidc_provider_arn
  vpc_id            = data.terraform_remote_state.infra.outputs.vpc_id
  region            = data.terraform_remote_state.infra.outputs.region
}



module "ebs_csi_driver" {

  source = "./modules/ebs-csi-driver"

  cluster_name = data.terraform_remote_state.infra.outputs.cluster_name

  cluster_oidc_issuer_url = data.terraform_remote_state.infra.outputs.oidc_issuer_url

  oidc_provider_arn = data.terraform_remote_state.infra.outputs.oidc_provider_arn

}



module "metrics_server" {

  source = "./modules/metrics-server"

  depends_on = [
    module.ebs_csi_driver
  ]

}





module "external_dns" {

  source = "./modules/external-dns"

  cluster_name      = data.terraform_remote_state.infra.outputs.cluster_name
  region            = data.terraform_remote_state.infra.outputs.region
  oidc_provider_arn = data.terraform_remote_state.infra.outputs.oidc_provider_arn
  oidc_provider_url = data.terraform_remote_state.infra.outputs.oidc_issuer_url

  hosted_zone_id = var.hosted_zone_id
}



module "acm" {
  source = "./modules/acm"

  hosted_zone_id = var.hosted_zone_id
}


module "namespaces" {
  source = "./modules/namespaces"
}







module "cluster_autoscaler" {

  source = "./modules/cluster-autoscaler"

  cluster_name = data.terraform_remote_state.infra.outputs.cluster_name

  region = data.terraform_remote_state.infra.outputs.region

   oidc_provider = data.terraform_remote_state.infra.outputs.oidc_issuer_url

  oidc_provider_arn = data.terraform_remote_state.infra.outputs.oidc_provider_arn

  chart_version = var.cluster_autoscaler_chart_version
}








data "terraform_remote_state" "infra" {
  backend = "s3"

  config = {
    bucket = "lovable-terraform-state-457724887427"
    key    = "stage-1-network/terraform.tfstate"
    region = "ap-south-1"
  }
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

module "ingress" {

  source = "./modules/ingress"

  namespace = var.namespace

  certificate_arn = module.acm.certificate_arn

  frontend_host = var.frontend_host
  api_host      = var.api_host
  preview_host  = var.preview_host

  frontend_service = var.frontend_service
  api_service      = var.api_service
  preview_service  = var.preview_service

  depends_on = [
    module.namespaces
  ]
}
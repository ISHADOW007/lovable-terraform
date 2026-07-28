
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
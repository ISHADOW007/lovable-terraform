##############################################
# Stage-1 Remote State
##############################################

data "terraform_remote_state" "infra" {

  backend = "local"

  config = {
    path = "../stage-1-infra/terraform.tfstate"
  }

}

##############################################
# Stage-2 Remote State
##############################################

data "terraform_remote_state" "addons" {

  backend = "local"

  config = {
    path = "../stage-2-addons/terraform.tfstate"
  }

}



module "argocd" {

  source = "./modules/argocd"

  certificate_arn = module.platform_acm.certificate_arn

  cluster_name = data.terraform_remote_state.infra.outputs.cluster_name

  host = "argocd.snapcart.dev"

}



module "platform_acm" {
  source = "./modules/acm"

  hosted_zone_id = var.hosted_zone_id

  domains = [
    "argocd.snapcart.dev",
    "grafana.snapcart.dev",
    "jenkins.snapcart.dev",
    "prometheus.snapcart.dev"
  ]

}




module "monitoring" {

  source = "./modules/monitoring"

  certificate_arn = module.platform_acm.certificate_arn

  grafana_host = "grafana.snapcart.dev"

  prometheus_host = "prometheus.snapcart.dev"

}



module "jenkins" {

  source = "./modules/jenkins"

  hostname = "jenkins.snapcart.dev"

  certificate_arn = module.platform_acm.certificate_arn

  jenkins_admin_password = var.jenkins_admin_password
}


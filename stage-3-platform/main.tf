##############################################
# Stage-1 Remote State
##############################################

data "terraform_remote_state" "infra" {
  backend = "s3"

  config = {
    bucket = "lovable-terraform-state-457724887427"
    key    = "stage-1-network/terraform.tfstate"
    region = "ap-south-1"
  }
}

##############################################
# Stage-2 Remote State
##############################################

data "terraform_remote_state" "addons" {
  backend = "s3"

  config = {
    bucket = "lovable-terraform-state-457724887427"
    key    = "stage-2-addons/terraform.tfstate"
    region = "ap-south-1"
  }
}

############################################################
# ACM
############################################################

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

############################################################
# Namespaces
############################################################

module "namespaces" {
  source = "./modules/namespaces"
}

############################################################
# AWS Secrets Manager
############################################################

module "secrets" {

  source = "./modules/secrets"

  ####################################################
  # Jenkins
  ####################################################

  jenkins_admin_user     = var.jenkins_admin_user
  jenkins_admin_password = var.jenkins_admin_password

  ####################################################
  # GitHub (Application Repository)
  ####################################################

  github_username = var.github_username
  github_token    = var.github_token

  ####################################################
  # GitOps Repository
  ####################################################

  gitops_username = var.gitops_username
  gitops_token    = var.gitops_token

  ####################################################
  # Docker Hub
  ####################################################

  dockerhub_username = var.dockerhub_username
  dockerhub_password = var.dockerhub_password

  ####################################################
  # SMTP
  ####################################################

  smtp_username = var.smtp_username
  smtp_password = var.smtp_password

  ####################################################
  # SonarQube
  ####################################################

  sonar_token = var.sonar_token

  sonarqube_admin_password = var.sonarqube_admin_password

  ####################################################
  # Database
  ####################################################

  db_username = var.db_username
  db_password = var.db_password

  ####################################################
  # Grafana
  ####################################################

  grafana_admin_user     = var.grafana_admin_user
  grafana_admin_password = var.grafana_admin_password
}

############################################################
# External Secrets
############################################################

module "external_secrets_config" {

  source = "./modules/external-secrets-config"

  region = var.aws_region

  depends_on = [
    module.namespaces,
    module.secrets
  ]
}

############################################################
# RDS
############################################################



############################################################
# ArgoCD
############################################################
module "argocd" {

  source = "./modules/argocd"

  certificate_arn = module.platform_acm.certificate_arn

  cluster_name = data.terraform_remote_state.infra.outputs.cluster_name

  host = "argocd.snapcart.dev"

  depends_on = [
    module.namespaces
  ]
}


module "argo_rollouts" {
  source = "./modules/argo-rollouts"

  depends_on = [
    module.argocd,
    module.namespaces
  ]
}


############################################################
# Monitoring
############################################################
module "monitoring" {

  source = "./modules/monitoring"

  namespace = "monitoring"

  certificate_arn = module.platform_acm.certificate_arn

  grafana_host = "grafana.snapcart.dev"

  prometheus_host = "prometheus.snapcart.dev"

  depends_on = [
    module.namespaces,
    module.external_secrets_config
  ]

}
############################################################
# logging
############################################################
module "logging" {

  source = "./modules/logging"

  namespace = "monitoring"

  depends_on = [
    module.namespaces
  ]

}


############################################################
# Jenkins
############################################################

module "jenkins" {

  count  = 1

  source = "./modules/jenkins"

  hostname        = "jenkins.snapcart.dev"
  certificate_arn = module.platform_acm.certificate_arn

  jenkins_admin_user     = var.jenkins_admin_user
  jenkins_admin_password = var.jenkins_admin_password

  github_username = var.github_username
  github_token    = var.github_token

  dockerhub_username = var.dockerhub_username
  dockerhub_password = var.dockerhub_password

  sonar_token = var.sonar_token

  smtp_username = var.smtp_username
  smtp_password = var.smtp_password

   gitops_username = var.gitops_username
gitops_token    = var.gitops_token

  depends_on = [
    module.jcasc,
    module.namespaces,
    module.external_secrets_config
  ]
}


############################################################
# SonarQube
############################################################




############################################################
# Jenkins JCasC
############################################################


module "jcasc" {
  source = "./modules/jcasc"

  depends_on = [
    module.namespaces
  ]
}







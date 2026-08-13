####################################################
# Cluster
####################################################

variable "cluster_name" {

  type = string

}

variable "region" {

  type = string

}

####################################################
# OIDC
####################################################

variable "oidc_provider_arn" {

  type = string

}

variable "oidc_provider_url" {

  type = string

}

####################################################
# Namespace
####################################################

variable "namespace" {

  type = string

  default = "external-secrets"

}


############################################################
# Bootstrap Flag
############################################################

variable "create_custom_resources" {
  description = "Whether to create ClusterSecretStore and ExternalSecrets"
  type        = bool
  default     = false
}
variable "cluster_name" {
  type = string
}

variable "region" {
  type = string
}

variable "namespace" {
  type    = string
  default = "kube-system"
}

variable "service_account_name" {
  type    = string
  default = "cluster-autoscaler"
}

variable "chart_version" {
  type = string
}

variable "oidc_provider" {
  type = string
}

variable "oidc_provider_arn" {
  type = string
}

variable "tags" {
  type    = map(string)
  default = {}
}
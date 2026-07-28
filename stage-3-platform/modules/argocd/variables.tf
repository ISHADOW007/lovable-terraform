variable "namespace" {
  type    = string
  default = "argocd"
}

variable "chart_version" {
  type    = string
  default = "8.2.2"
}

variable "certificate_arn" {
  type = string
}

variable "host" {
  type = string
}

variable "cluster_name" {
  type = string
}


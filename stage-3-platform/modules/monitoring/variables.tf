variable "certificate_arn" {

  description = "ACM certificate ARN used by ALB ingress"

  type = string

}


variable "grafana_host" {

  description = "Hostname for Grafana ingress"

  type = string

}


variable "prometheus_host" {

  description = "Hostname for Prometheus ingress"

  type = string

}
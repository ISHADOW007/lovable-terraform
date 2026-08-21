variable "aws_region" {
  default = "ap-south-1"
}


variable "hosted_zone_id" {
  type = string
}


variable "namespace" {
  default = "lovable-core"
}

variable "frontend_host" {
  default = "lovable.snapcart.dev"
}

variable "api_host" {
  default = "api.snapcart.dev"
}

variable "preview_host" {
  default = "*.previews.snapcart.dev"
}

variable "frontend_service" {
  default = "lovable-frontend"
}

variable "api_service" {
  default = "api-gateway"
}

variable "preview_service" {
  default = "lovable-me-proxy"
}


variable "cluster_autoscaler_chart_version" {

  type = string
}

variable "tags" {
  type    = map(string)
  default = {}
}
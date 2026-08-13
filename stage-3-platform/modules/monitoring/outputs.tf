output "grafana_url" {

  value = "https://${var.grafana_host}"

}

output "prometheus_url" {

  value = "https://${var.prometheus_host}"

}
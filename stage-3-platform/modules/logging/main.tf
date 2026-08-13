resource "helm_release" "logging" {
  name       = "logging"
  repository = "https://grafana.github.io/helm-charts"
  chart      = "loki-stack"
  version    = "2.10.3"
  namespace  = var.namespace

  values = [
    file("${path.module}/values.yaml")
  ]
}
resource "kubernetes_namespace" "this" {
  metadata {
    name = var.namespace
  }
}

resource "helm_release" "this" {
  name             = "argo-rollouts"
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-rollouts"
  version          = var.chart_version

  namespace        = var.namespace
  create_namespace = false

  depends_on = [
    kubernetes_namespace.this
  ]
}
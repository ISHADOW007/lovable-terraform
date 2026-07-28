resource "helm_release" "this" {
  name       = "metrics-server"
  repository = "https://kubernetes-sigs.github.io/metrics-server"
  chart      = "metrics-server"
  namespace  = var.namespace
  version    = "3.13.0"

  wait    = true
  timeout = 600

  set = [
    {
      name  = "args[0]"
      value = "--kubelet-insecure-tls"
    },
    {
      name  = "args[1]"
      value = "--kubelet-preferred-address-types=InternalIP"
    }
  ]
}
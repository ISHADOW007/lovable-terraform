



output "namespace" {
  value = kubernetes_namespace.this.metadata[0].name
}

output "host" {
  value = var.host
}



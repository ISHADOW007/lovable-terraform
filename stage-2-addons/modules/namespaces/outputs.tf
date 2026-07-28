output "lovable_core" {
  value = kubernetes_namespace.lovable_core.metadata[0].name
}

output "lovable_previews" {
  value = kubernetes_namespace.lovable_previews.metadata[0].name
}
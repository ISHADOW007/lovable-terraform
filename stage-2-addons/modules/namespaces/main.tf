resource "kubernetes_namespace" "lovable_core" {
  metadata {
    name = "lovable-core"
  }
}

resource "kubernetes_namespace" "lovable_previews" {
  metadata {
    name = "lovable-previews"
  }
}
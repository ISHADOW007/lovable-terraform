resource "kubernetes_namespace_v1" "this" {

  metadata {

    name = var.namespace

    labels = {

      app = "external-secrets"

    }

  }

}
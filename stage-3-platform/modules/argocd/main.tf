resource "kubernetes_namespace" "this" {

  metadata {
    name = var.namespace
  }

}


resource "helm_release" "this" {

  name             = "argocd"
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  version          = var.chart_version
  namespace        = var.namespace
  create_namespace = false

  set = [
    {
      name  = "configs.params.server\\.insecure"
      value = "true"
    }
  ]

  depends_on = [
    kubernetes_namespace.this
  ]

}


resource "kubernetes_ingress_v1" "this" {

  metadata {

    name      = "argocd"
    namespace = var.namespace

    annotations = {

      "kubernetes.io/ingress.class" = "alb"

      "alb.ingress.kubernetes.io/scheme" = "internet-facing"

      "alb.ingress.kubernetes.io/target-type" = "ip"

      "alb.ingress.kubernetes.io/listen-ports" = "[{\"HTTP\":80},{\"HTTPS\":443}]"

      "alb.ingress.kubernetes.io/ssl-redirect" = "443"

      "alb.ingress.kubernetes.io/certificate-arn" = var.certificate_arn

      "external-dns.alpha.kubernetes.io/hostname" = var.host

    }

  }

  spec {

    ingress_class_name = "alb"

    rule {

      host = var.host

      http {

        path {

          path = "/"

          path_type = "Prefix"

          backend {

            service {

              name = "argocd-server"

              port {

                number = 80

              }

            }

          }

        }

      }

    }

  }

  depends_on = [
    helm_release.this
  ]

}


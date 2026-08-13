resource "kubernetes_ingress_v1" "this" {

  metadata {

    name = "jenkins"

    namespace = var.namespace

    annotations = {

      "kubernetes.io/ingress.class" = "alb"

      "alb.ingress.kubernetes.io/scheme" = "internet-facing"

      "alb.ingress.kubernetes.io/target-type" = "ip"

      "alb.ingress.kubernetes.io/listen-ports" = "[{\"HTTP\":80},{\"HTTPS\":443}]"

      "alb.ingress.kubernetes.io/ssl-redirect" = "443"

      "alb.ingress.kubernetes.io/certificate-arn" = var.certificate_arn

      "external-dns.alpha.kubernetes.io/hostname" = var.hostname

      "alb.ingress.kubernetes.io/healthcheck-path" = "/login"

      "alb.ingress.kubernetes.io/success-codes" = "200,302"

    }

  }

  spec {

    ingress_class_name = "alb"

    rule {

      host = var.hostname

      http {

        path {

          path = "/"

          path_type = "Prefix"

          backend {

            service {

              name = "jenkins"

              port {

                number = 8080

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
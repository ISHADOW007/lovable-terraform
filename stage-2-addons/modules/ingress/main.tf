resource "kubernetes_ingress_v1" "this" {

  metadata {
    name      = "lovable-main-ingress"
    namespace = var.namespace

    annotations = {
      "ingress_class_name" = "alb"

      "alb.ingress.kubernetes.io/scheme"      = "internet-facing"
      "alb.ingress.kubernetes.io/target-type" = "ip"

      "alb.ingress.kubernetes.io/listen-ports" = "[{\"HTTP\":80},{\"HTTPS\":443}]"

      "alb.ingress.kubernetes.io/ssl-redirect" = "443"

      "alb.ingress.kubernetes.io/certificate-arn" = var.certificate_arn


      "external-dns.alpha.kubernetes.io/hostname" = "${var.frontend_host},${var.api_host}"




    }
  }

  spec {

    ingress_class_name = "alb"

    rule {

      host = var.frontend_host

      http {

        path {

          path = "/"

          path_type = "Prefix"

          backend {

            service {

              name = var.frontend_service

              port {
                number = 80
              }

            }

          }

        }

      }

    }

    rule {

      host = var.api_host

      http {

        path {

          path = "/"

          path_type = "Prefix"

          backend {

            service {

              name = var.api_service

              port {

                number = 80

              }

            }

          }

        }

      }

    }

    rule {

      host = var.preview_host

      http {

        path {

          path = "/"

          path_type = "Prefix"

          backend {

            service {

              name = var.preview_service

              port {

                number = 80

              }

            }

          }

        }

      }

    }

  }

}
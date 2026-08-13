resource "kubernetes_ingress_v1" "prometheus" {

  metadata {

    name = "prometheus"

    namespace = var.namespace

    annotations = {

      "kubernetes.io/ingress.class"               = "alb"

      "alb.ingress.kubernetes.io/scheme"         = "internet-facing"

      "alb.ingress.kubernetes.io/target-type"    = "ip"

      "alb.ingress.kubernetes.io/listen-ports"   = "[{\"HTTP\":80},{\"HTTPS\":443}]"

      "alb.ingress.kubernetes.io/ssl-redirect"   = "443"

      "alb.ingress.kubernetes.io/certificate-arn" = var.certificate_arn

      "external-dns.alpha.kubernetes.io/hostname" = var.prometheus_host
    }

  }

  spec {

    ingress_class_name = "alb"

    rule {

      host = var.prometheus_host

      http {

        path {

          path = "/"

          path_type = "Prefix"

          backend {

            service {

              name = "monitoring-kube-prometheus-prometheus"

              port {

                number = 9090

              }

            }

          }

        }

      }

    }

  }

}
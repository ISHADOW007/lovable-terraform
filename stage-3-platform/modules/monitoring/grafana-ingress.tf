resource "kubernetes_ingress_v1" "grafana" {


  metadata {

    name = "grafana"

    namespace = "monitoring"


    annotations = {

      "kubernetes.io/ingress.class" = "alb"

      "alb.ingress.kubernetes.io/scheme" = "internet-facing"

      "alb.ingress.kubernetes.io/target-type" = "ip"

      "alb.ingress.kubernetes.io/listen-ports" = "[{\"HTTP\":80},{\"HTTPS\":443}]"

      "alb.ingress.kubernetes.io/ssl-redirect" = "443"

      "alb.ingress.kubernetes.io/certificate-arn" = var.certificate_arn

      "external-dns.alpha.kubernetes.io/hostname" = var.grafana_host

    }

  }


  spec {

    ingress_class_name = "alb"


    rule {

      host = var.grafana_host


      http {


        path {


          path = "/"

          path_type = "Prefix"


          backend {


            service {


              name = "monitoring-grafana"


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
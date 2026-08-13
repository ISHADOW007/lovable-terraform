############################################################
# SonarQube ALB Ingress
############################################################

resource "kubernetes_ingress_v1" "this" {

  metadata {

    name = "sonarqube"

    namespace = var.namespace

    annotations = {

      ####################################################
      # AWS Load Balancer Controller
      ####################################################

      "kubernetes.io/ingress.class" = "alb"

      "alb.ingress.kubernetes.io/scheme" = "internet-facing"

      "alb.ingress.kubernetes.io/target-type" = "ip"

      ####################################################
      # Listener
      ####################################################

      "alb.ingress.kubernetes.io/listen-ports" = "[{\"HTTP\":80},{\"HTTPS\":443}]"

      "alb.ingress.kubernetes.io/ssl-redirect" = "443"

      ####################################################
      # Certificate
      ####################################################

      "alb.ingress.kubernetes.io/certificate-arn" = var.certificate_arn

      ####################################################
      # Health Check
      ####################################################

      "alb.ingress.kubernetes.io/healthcheck-path" = "/api/system/status"

      "alb.ingress.kubernetes.io/healthcheck-port" = "traffic-port"

      "alb.ingress.kubernetes.io/success-codes" = "200"

      ####################################################
      # External DNS
      ####################################################

      "external-dns.alpha.kubernetes.io/hostname" = var.hostname

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

              name = "sonarqube-sonarqube"

              port {

                number = 9000

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
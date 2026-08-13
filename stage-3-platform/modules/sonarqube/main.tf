

############################################################
# SonarQube Helm Release
############################################################

resource "helm_release" "this" {

  name = "sonarqube"

  repository = "https://SonarSource.github.io/helm-chart-sonarqube"

  chart = "sonarqube"

  namespace = var.namespace

  create_namespace = false

  wait = true

  timeout = 1800

  values = [

    templatefile("${path.module}/values.yaml", {

      jdbc_url = var.jdbc_url

      jdbc_username = var.jdbc_username

      jdbc_password = var.jdbc_password

    })

  ]

  depends_on = [

  

    kubernetes_secret.database

  ]

}



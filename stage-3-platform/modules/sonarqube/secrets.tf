############################################################
# SonarQube Database Secret
############################################################

resource "kubernetes_secret" "database" {

  metadata {

    name = "sonarqube-db-secret"

    namespace = var.namespace

    labels = {
      app = "sonarqube"
    }

  }

  type = "Opaque"

  data = {

    jdbcUsername = base64encode(var.jdbc_username)

    jdbcPassword = base64encode(var.jdbc_password)

  }

}
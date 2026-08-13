resource "kubernetes_manifest" "jenkins" {

  field_manager {
    name            = "terraform"
    force_conflicts = true
  }

  manifest = {

    apiVersion = "external-secrets.io/v1"

    kind = "ExternalSecret"

    metadata = {
      name      = "jenkins-secret"
      namespace = "jenkins"
    }

    spec = {

      refreshInterval = "1h"

      secretStoreRef = {
        name = "aws-secrets-manager"
        kind = "ClusterSecretStore"
      }

      target = {
        name           = "jenkins-secrets"
        creationPolicy = "Owner"
      }

      dataFrom = [
        {
          extract = {
            key = "lovable/jenkins"
          }
        }
      ]
    }
  }

  depends_on = [
    kubernetes_manifest.cluster_secret_store
  ]
}

resource "kubernetes_manifest" "sonarqube" {

  field_manager {
    name            = "terraform"
    force_conflicts = true
  }

  manifest = {

    apiVersion = "external-secrets.io/v1"

    kind = "ExternalSecret"

    metadata = {
      name      = "sonarqube-secret"
      namespace = "sonarqube"
    }

    spec = {

      refreshInterval = "1h"

      secretStoreRef = {
        name = "aws-secrets-manager"
        kind = "ClusterSecretStore"
      }

      target = {
        name           = "sonarqube-secret"
        creationPolicy = "Owner"
      }

      dataFrom = [
        {
          extract = {
            key = "lovable/sonarqube"
          }
        }
      ]
    }
  }

  depends_on = [
    kubernetes_manifest.cluster_secret_store
  ]
}

resource "kubernetes_manifest" "grafana" {

  field_manager {
    name            = "terraform"
    force_conflicts = true
  }

  manifest = {

    apiVersion = "external-secrets.io/v1"

    kind = "ExternalSecret"

    metadata = {
      name      = "grafana-secret"
      namespace = "monitoring"
    }

    spec = {

      refreshInterval = "1h"

      secretStoreRef = {
        name = "aws-secrets-manager"
        kind = "ClusterSecretStore"
      }

      target = {
        name           = "grafana-secret"
        creationPolicy = "Owner"
      }

      dataFrom = [
        {
          extract = {
            key = "lovable/grafana"
          }
        }
      ]
    }
  }

  depends_on = [
    kubernetes_manifest.cluster_secret_store
  ]
}

resource "kubernetes_manifest" "rds" {

  field_manager {
    name            = "terraform"
    force_conflicts = true
  }

  manifest = {

    apiVersion = "external-secrets.io/v1"

    kind = "ExternalSecret"

    metadata = {
      name      = "rds-secret"
      namespace = "sonarqube"
    }

    spec = {

      refreshInterval = "1h"

      secretStoreRef = {
        name = "aws-secrets-manager"
        kind = "ClusterSecretStore"
      }

      target = {
        name           = "rds-secret"
        creationPolicy = "Owner"
      }

      dataFrom = [
        {
          extract = {
            key = "lovable/rds"
          }
        }
      ]
    }
  }

  depends_on = [
    kubernetes_manifest.cluster_secret_store
  ]
}
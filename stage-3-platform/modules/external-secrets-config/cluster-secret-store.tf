resource "kubernetes_manifest" "cluster_secret_store" {

  manifest = {

    apiVersion = "external-secrets.io/v1"

    kind = "ClusterSecretStore"

    metadata = {
      name = "aws-secrets-manager"
    }

    spec = {

      provider = {

        aws = {

          service = "SecretsManager"

          region = var.region

          auth = {

            jwt = {

              serviceAccountRef = {

                name = "external-secrets"

                namespace = "external-secrets"

              }

            }

          }

        }

      }

    }

  }

}
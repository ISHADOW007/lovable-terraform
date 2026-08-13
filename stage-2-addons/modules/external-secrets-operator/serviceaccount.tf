############################################################
# External Secrets Service Account
############################################################

resource "kubernetes_service_account_v1" "external_secrets" {

  metadata {

    name = "external-secrets"

    namespace = kubernetes_namespace_v1.this.metadata[0].name

    annotations = {

      "eks.amazonaws.com/role-arn" = aws_iam_role.external_secrets.arn

    }

    labels = {

      "app.kubernetes.io/name" = "external-secrets"

      "app.kubernetes.io/managed-by" = "Terraform"

    }

  }

  automount_service_account_token = true

}
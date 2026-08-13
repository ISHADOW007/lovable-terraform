#########################################################
# Jenkins Namespace Service Account
#########################################################

resource "kubernetes_service_account" "jenkins" {

  metadata {

    name = "jenkins"

    namespace = var.namespace

    labels = {
      app = "jenkins"
    }

  }

  automount_service_account_token = true

}
#########################################################
# Jenkins Role Binding
#########################################################

resource "kubernetes_role_binding" "jenkins" {

  metadata {

    name = "jenkins"

    namespace = var.namespace

    labels = {
      app = "jenkins"
    }

  }

  #######################################################
  # Bind ServiceAccount
  #######################################################

  subject {

    kind = "ServiceAccount"

    name = kubernetes_service_account.jenkins.metadata[0].name

    namespace = var.namespace

  }

  #######################################################
  # Bind Role
  #######################################################

  role_ref {

    api_group = "rbac.authorization.k8s.io"

    kind = "Role"

    name = kubernetes_role.jenkins.metadata[0].name

  }

}
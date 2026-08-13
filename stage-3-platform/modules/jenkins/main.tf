############################################################
# Namespace
############################################################



############################################################
# Helm Release
############################################################

resource "helm_release" "this" {

  name = "jenkins"

  repository = "https://charts.jenkins.io"

  chart = "jenkins"

  namespace = var.namespace

  create_namespace = false

  wait = true

  timeout = 1800

  values = [

    templatefile("${path.module}/values.yaml", {

      ####################################################
      # Jenkins
      ####################################################

      admin_user = var.jenkins_admin_user

      admin_password = var.jenkins_admin_password

      ####################################################
      # Storage
      ####################################################

      storage_class = "gp2"

      storage_size = "20Gi"

    })

  ]

  ####################################################
  # Dependencies
  ####################################################

  depends_on = [

    

    kubernetes_service_account.jenkins,

    kubernetes_role.jenkins,

    kubernetes_role_binding.jenkins,



  ]

}




resource "kubernetes_namespace" "this" {
  metadata {
    name = "jenkins"
  }
}

resource "helm_release" "this" {
  name       = "jenkins"
  repository = "https://charts.jenkins.io"
  chart      = "jenkins"
  namespace  = kubernetes_namespace.this.metadata[0].name

  create_namespace = false

  wait    = true
  timeout = 1200

 set = [
  {
    name  = "controller.serviceType"
    value = "ClusterIP"
  },

  {
    name  = "persistence.enabled"
    value = "true"
  },

  {
    name  = "persistence.storageClass"
    value = "gp2"
  },

  {
    name  = "persistence.size"
    value = "20Gi"
  },

  {
    name  = "controller.admin.username"
    value = "admin"
  },

  {
    name  = "controller.admin.password"
    value = var.jenkins_admin_password
  }
]

  depends_on = [
    kubernetes_namespace.this
  ]
}
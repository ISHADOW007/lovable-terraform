resource "kubernetes_config_map" "jcasc" {

  metadata {
    name      = "jenkins-jcasc"
    namespace = "jenkins"

    labels = {
      "jenkins-jenkins-config" = "true"
    }
  }

  data = {
    "credentials.yaml" = file("${path.module}/credentials.yaml")
    "jenkins.yaml"     = file("${path.module}/jenkins.yaml")
    "jobs.yaml"        = file("${path.module}/jobs.yaml")
    "kubernetes.yaml"  = file("${path.module}/kubernetes.yaml")
    "location.yaml"    = file("${path.module}/location.yaml")
    "security.yaml"    = file("${path.module}/security.yaml")
    "smtp.yaml"        = file("${path.module}/smtp.yaml")
    "sonarqube.yaml"   = file("${path.module}/sonarqube.yaml")
    "tools.yaml"       = file("${path.module}/tools.yaml")

    # Add this
    "jobs.groovy" = file("${path.module}/scripts/jobs.groovy")
  }
}
####################################################
# Jenkins Secret
####################################################

resource "aws_secretsmanager_secret" "jenkins" {

  name = "${local.project}/jenkins"

  description = "Jenkins Credentials"

  tags = local.tags

}

resource "aws_secretsmanager_secret_version" "jenkins" {

  secret_id = aws_secretsmanager_secret.jenkins.id

  secret_string = jsonencode({

    JENKINS_ADMIN_USER     = var.jenkins_admin_user
    JENKINS_ADMIN_PASSWORD = var.jenkins_admin_password

    GITHUB_USERNAME        = var.github_username
    GITHUB_TOKEN           = var.github_token

    DOCKERHUB_USERNAME     = var.dockerhub_username
    DOCKERHUB_PASSWORD     = var.dockerhub_password

    SONAR_TOKEN            = var.sonar_token

    SMTP_USERNAME          = var.smtp_username
    SMTP_PASSWORD          = var.smtp_password

    ####################################################
    # GitOps Repository
    ####################################################

    GITOPS_USERNAME        = var.gitops_username
    GITOPS_TOKEN           = var.gitops_token

  })
}


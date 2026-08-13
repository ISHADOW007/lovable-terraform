resource "aws_secretsmanager_secret" "sonarqube" {

  name = "${local.project}/sonarqube"

  description = "SonarQube Credentials"

  tags = local.tags

}

resource "aws_secretsmanager_secret_version" "sonarqube" {

  secret_id = aws_secretsmanager_secret.sonarqube.id

  secret_string = jsonencode({

    admin_password = var.sonarqube_admin_password

  })

}
resource "aws_secretsmanager_secret" "grafana" {

  name = "${local.project}/grafana"

  description = "Grafana Credentials"

  tags = local.tags

}

resource "aws_secretsmanager_secret_version" "grafana" {

  secret_id = aws_secretsmanager_secret.grafana.id

  secret_string = jsonencode({

    admin_user = var.grafana_admin_user

    admin_password = var.grafana_admin_password

  })

}
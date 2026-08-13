output "jenkins_secret_arn" {

  value = aws_secretsmanager_secret.jenkins.arn

}

output "sonarqube_secret_arn" {

  value = aws_secretsmanager_secret.sonarqube.arn

}

output "rds_secret_arn" {

  value = aws_secretsmanager_secret.rds.arn

}

output "grafana_secret_arn" {

  value = aws_secretsmanager_secret.grafana.arn

}
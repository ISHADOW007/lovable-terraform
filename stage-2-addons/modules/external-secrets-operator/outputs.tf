output "namespace" {
  value = kubernetes_namespace_v1.this.metadata[0].name
}

output "service_account_name" {
  value = kubernetes_service_account_v1.external_secrets.metadata[0].name
}

output "iam_role_arn" {
  value = aws_iam_role.external_secrets.arn
}

output "iam_role_name" {
  value = aws_iam_role.external_secrets.name
}
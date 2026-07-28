output "oidc_provider_arn" {
  value = aws_iam_openid_connect_provider.this.arn
}

output "oidc_issuer_url" {
  value = aws_iam_openid_connect_provider.this.url
}
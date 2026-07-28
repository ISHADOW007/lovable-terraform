output "cluster_name" {
  value = module.eks.cluster_name
}

output "cluster_endpoint" {
  value = module.eks.cluster_endpoint
}

output "cluster_ca_certificate" {
  value     = module.eks.cluster_ca_certificate
  sensitive = true
}



output "region" {
  value = var.aws_region
}

output "vpc_id" {
  value = module.vpc.vpc_id
}



output "oidc_provider_arn" {
  value = module.oidc.oidc_provider_arn
}

output "oidc_issuer_url" {
  value = module.oidc.oidc_issuer_url
}
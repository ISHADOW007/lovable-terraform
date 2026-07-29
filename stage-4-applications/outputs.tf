output "github_actions_role_arn" {

  value = module.github_oidc.github_actions_role_arn

}


output "oidc_provider_arn" {

  value = module.github_oidc.oidc_provider_arn

}
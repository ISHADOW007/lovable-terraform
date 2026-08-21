module "ingress" {

  source = "./modules/ingress"

  namespace = var.namespace

  certificate_arn = module.acm.certificate_arn

  frontend_host = var.frontend_host
  api_host      = var.api_host
  preview_host  = var.preview_host

  frontend_service = var.frontend_service
  api_service      = var.api_service
  preview_service  = var.preview_service

  depends_on = [
    module.namespaces
  ]
}
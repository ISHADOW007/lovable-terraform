############################################################
# External Secrets Operator
############################################################

resource "helm_release" "external_secrets" {

  name = "external-secrets"

  repository = "https://charts.external-secrets.io"

  chart = "external-secrets"

  version = "0.20.2"

  namespace = kubernetes_namespace_v1.this.metadata[0].name

  create_namespace = false

  wait = true

  timeout = 900

  atomic = true

  cleanup_on_fail = true

  dependency_update = true

  values = [

    <<-EOF

installCRDs: true

serviceAccount:

  create: false

  name: external-secrets

webhook:

  create: true

certController:

  create: true

leaderElect: true

metrics:

  service:

    enabled: true

EOF

  ]

  depends_on = [

    kubernetes_service_account_v1.external_secrets

  ]

}
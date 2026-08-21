resource "helm_release" "this" {

  name = "cluster-autoscaler"

  repository = "https://kubernetes.github.io/autoscaler"

  chart = "cluster-autoscaler"

  version = var.chart_version

  namespace = var.namespace

  create_namespace = false

  wait = true

  timeout = 900

  atomic = true

  cleanup_on_fail = true

  values = [

    yamlencode({

      cloudProvider = "aws"

      awsRegion = var.region

      autoDiscovery = {
        clusterName = var.cluster_name
      }

      rbac = {

        create = true

        serviceAccount = {

          create = true

          name = var.service_account_name

          annotations = {

            "eks.amazonaws.com/role-arn" = aws_iam_role.this.arn

          }
        }
      }

      extraArgs = {

        "balance-similar-node-groups" = true

        "skip-nodes-with-local-storage" = false

        "skip-nodes-with-system-pods" = false

        "expander" = "least-waste"

        "scale-down-utilization-threshold" = "0.5"

        "scale-down-unneeded-time" = "10m"
      }

      resources = {

        requests = {
          cpu    = "100m"
          memory = "300Mi"
        }

        limits = {
          cpu    = "200m"
          memory = "500Mi"
        }
      }
    })
  ]

  depends_on = [
    aws_iam_role.this
  ]
}
#############################################
# IAM Policy for ExternalDNS
#############################################

resource "aws_iam_policy" "external_dns" {

  name        = "${var.cluster_name}-external-dns-policy"
  description = "Allows ExternalDNS to manage Route53 records"

  policy = jsonencode({

    Version = "2012-10-17"

    Statement = [

      {
        Effect = "Allow"

        Action = [
          "route53:ChangeResourceRecordSets"
        ]

        Resource = [
          "arn:aws:route53:::hostedzone/${var.hosted_zone_id}"
        ]
      },

      {
        Effect = "Allow"

        Action = [
          "route53:ListHostedZones",
          "route53:ListResourceRecordSets",
          "route53:ListTagsForResource"
        ]

        Resource = "*"
      }

    ]

  })

}






#############################################
# IAM Trust Policy for IRSA
#############################################

data "aws_iam_policy_document" "external_dns_assume_role" {

  statement {

    effect = "Allow"

    actions = [
      "sts:AssumeRoleWithWebIdentity"
    ]

    principals {

      type = "Federated"

      identifiers = [
        var.oidc_provider_arn
      ]
    }

    condition {

      test = "StringEquals"

      variable = "${var.oidc_provider_url}:sub"

      values = [
        "system:serviceaccount:kube-system:external-dns"
      ]
    }

  }

}


#############################################
# IAM Role
#############################################

resource "aws_iam_role" "external_dns" {

  name = "${var.cluster_name}-external-dns-role"

  assume_role_policy = data.aws_iam_policy_document.external_dns_assume_role.json

}


#############################################
# Attach IAM Policy to IAM Role
#############################################

resource "aws_iam_role_policy_attachment" "external_dns" {

  role = aws_iam_role.external_dns.name

  policy_arn = aws_iam_policy.external_dns.arn

}


#############################################
# ExternalDNS Service Account
#############################################

resource "kubernetes_service_account" "external_dns" {

  metadata {

    name      = "external-dns"
    namespace = "kube-system"

    annotations = {
      "eks.amazonaws.com/role-arn" = aws_iam_role.external_dns.arn
    }

    labels = {
      "app.kubernetes.io/name" = "external-dns"
    }
  }
}



#############################################
# ExternalDNS Helm Release
#############################################

resource "helm_release" "external_dns" {

  name       = "external-dns"
  repository = "https://kubernetes-sigs.github.io/external-dns/"
  chart      = "external-dns"
  namespace  = "kube-system"

  depends_on = [
    kubernetes_service_account.external_dns
  ]

  set = [
    {
      name  = "serviceAccount.create"
      value = "false"
    },
    {
      name  = "serviceAccount.name"
      value = kubernetes_service_account.external_dns.metadata[0].name
    },
    {
      name  = "provider.name"
      value = "aws"
    },
    {
      name  = "aws.region"
      value = var.region
    },
    {
      name  = "domainFilters[0]"
      value = "snapcart.dev"
    },
    {
      name  = "policy"
      value = "sync"
    },
    {
      name  = "registry"
      value = "txt"
    },
    {
      name  = "txtOwnerId"
      value = var.cluster_name
    },
    {
      name  = "sources[0]"
      value = "ingress"
    }
  ]
}
############################################################
# IAM Policy
############################################################

resource "aws_iam_policy" "external_secrets" {

  name        = "${var.cluster_name}-external-secrets"
  description = "External Secrets Operator"

  policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Action = [
          "secretsmanager:GetSecretValue",
          "secretsmanager:DescribeSecret",
          "secretsmanager:ListSecrets"
        ]

        Resource = [
          "arn:aws:secretsmanager:${var.region}:*:secret:lovable/*"
        ]
      }
    ]
  })

}

############################################################
# IAM Role
############################################################

resource "aws_iam_role" "external_secrets" {

  name = "${var.cluster_name}-external-secrets"

  assume_role_policy = jsonencode({

    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Principal = {
          Federated = var.oidc_provider_arn
        }

        Action = "sts:AssumeRoleWithWebIdentity"

        Condition = {
          StringEquals = {
            "${replace(var.oidc_provider_url, "https://", "")}:sub" = "system:serviceaccount:${var.namespace}:external-secrets"
          }
        }
      }
    ]

  })

}

############################################################
# Attach Policy
############################################################

resource "aws_iam_role_policy_attachment" "external_secrets" {

  role       = aws_iam_role.external_secrets.name
  policy_arn = aws_iam_policy.external_secrets.arn

}
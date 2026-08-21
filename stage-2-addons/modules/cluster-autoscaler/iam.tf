data "aws_iam_policy_document" "assume_role" {

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

      variable = "${var.oidc_provider}:sub"

      values = [
        "system:serviceaccount:kube-system:${var.service_account_name}"
      ]
    }

    condition {

      test = "StringEquals"

      variable = "${var.oidc_provider}:aud"

      values = [
        "sts.amazonaws.com"
      ]
    }
  }
}


resource "aws_iam_role" "this" {

  name = "${var.cluster_name}-cluster-autoscaler"

  assume_role_policy = data.aws_iam_policy_document.assume_role.json

  tags = var.tags
}
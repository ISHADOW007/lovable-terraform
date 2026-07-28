resource "aws_iam_role" "this" {

  name = "AmazonEBSCSIDriverRole"

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
            "${replace(var.cluster_oidc_issuer_url, "https://", "")}:sub" = "system:serviceaccount:kube-system:ebs-csi-controller-sa"

            "${replace(var.cluster_oidc_issuer_url, "https://", "")}:aud" = "sts.amazonaws.com"
          }
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "this" {

  role = aws_iam_role.this.name

  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"

}
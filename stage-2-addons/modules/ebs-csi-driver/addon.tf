resource "aws_eks_addon" "this" {

  cluster_name = var.cluster_name

  addon_name = "aws-ebs-csi-driver"

  service_account_role_arn = aws_iam_role.this.arn

  resolve_conflicts_on_create = "OVERWRITE"

  resolve_conflicts_on_update = "OVERWRITE"

}
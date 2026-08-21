data "aws_iam_policy_document" "this" {

  statement {

    effect = "Allow"

    actions = [

      "autoscaling:SetDesiredCapacity",

      "autoscaling:TerminateInstanceInAutoScalingGroup",

      "autoscaling:DescribeAutoScalingGroups",

      "autoscaling:DescribeAutoScalingInstances",

      "autoscaling:DescribeLaunchConfigurations",

      "autoscaling:DescribeScalingActivities",

      "autoscaling:DescribeTags",

      "ec2:DescribeImages",

      "ec2:DescribeInstanceTypes",

      "ec2:DescribeLaunchTemplateVersions"
    ]

    resources = [
      "*"
    ]
  }
}


resource "aws_iam_role_policy" "this" {

  name = "${var.cluster_name}-cluster-autoscaler"

  role = aws_iam_role.this.id

  policy = data.aws_iam_policy_document.this.json
}
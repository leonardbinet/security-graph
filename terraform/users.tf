# User to use for serverless apps deployments
resource "aws_iam_user" "tf-admin" {
  name = "tf-${local.service_name}-${var.stage}-admin"

  tags = local.tags
}

resource "aws_iam_access_key" "tf-admin" {
  user = aws_iam_user.tf-admin.name
}

resource "aws_iam_group_membership" "tf-admin-membership" {
  name = "${aws_iam_user.tf-admin.name}-group-membership"

  users = [
    aws_iam_user.tf-admin.name,
  ]

  group = module.serverless.iam_group_admin_name
}

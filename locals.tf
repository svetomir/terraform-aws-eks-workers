locals {
    node_role_arn = var.node_role_arn == "" ? aws_iam_role.main[0].arn : var.node_role_arn
}
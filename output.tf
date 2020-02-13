output "eks_node_group_arn" {
    value       = aws_eks_node_group.main.arn
    description = "Amazon Resource Name (ARN) of the EKS Node Group."
}

output "eks_node_group_id" {
    value       = aws_eks_node_group.main.id
    description = "EKS Cluster name and EKS Node Group name separated by a colon (:)."
}

output "eks_node_group_resources" {
    value       = aws_eks_node_group.main.resources
    description = "List of objects containing information about underlying resources."
}

output "eks_node_group_status" {
    value       = aws_eks_node_group.main.status
    description = "Status of the EKS Node Group."
}

output "iam_role_arn" {
    value       = aws_iam_role.main.*.arn
    description = "The Amazon Resource Name (ARN) specifying the role."
}

output "iam_role_create_date" {
    value       = aws_iam_role.main.*.create_date
    description = "The creation date of the IAM role."
}

output "iam_role_description" {
    value       = aws_iam_role.main.*.description
    description = "The description of the role."
}

output "iam_role_id" {
    value       = aws_iam_role.main.*.id
    description = "The name of the role."
}

output "iam_role_name" {
    value       = aws_iam_role.main.*.name
    description = "The name of the role."
}

output "iam_role_unique_id" {
    value       = aws_iam_role.main.*.name
    description = "The stable and unique string identifying the role."
}

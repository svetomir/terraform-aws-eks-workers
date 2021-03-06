output "node_group_arn" {
    value       = aws_eks_node_group.main.arn
    description = "Amazon Resource Name (ARN) of the EKS Node Group."
}

output "node_group_id" {
    value       = aws_eks_node_group.main.id
    description = "EKS Cluster name and EKS Node Group name separated by a colon (:)."
}

output "node_group_resources" {
    value       = aws_eks_node_group.main.resources
    description = "List of objects containing information about underlying resources."
}

output "node_group_status" {
    value       = aws_eks_node_group.main.status
    description = "Status of the EKS Node Group."
}

output "iam_role_arn" {
    value       = concat(aws_iam_role.main.*.arn, [""])[0]
    description = "The Amazon Resource Name (ARN) specifying the role."
}

output "iam_role_create_date" {
    value       = concat(aws_iam_role.main.*.create_date, [""])[0]
    description = "The creation date of the IAM role."
}

output "iam_role_description" {
    value       = concat(aws_iam_role.main.*.description, [""])[0]
    description = "The description of the role."
}

output "iam_role_id" {
    value       = concat(aws_iam_role.main.*.id, [""])[0]
    description = "The name of the role."
}

output "iam_role_name" {
    value       = concat(aws_iam_role.main.*.name, [""])[0]
    description = "The name of the role."
}

output "iam_role_unique_id" {
    value       = concat(aws_iam_role.main.*.unique_id, [""])[0]
    description = "The stable and unique string identifying the role."
}

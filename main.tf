resource "aws_eks_node_group" "main" {
    cluster_name    = var.cluster_name
    node_group_name = var.node_group_name
    node_role_arn   = local.node_role_arn
    subnet_ids      = var.subnet_ids
    
    scaling_config {
        desired_size = var.desired_size
        max_size     = var.max_size
        min_size     = var.min_size
    }

    ami_type        = var.ami_type
    disk_size       = var.disk_size
    instance_types  = var.instance_types
    labels          = var.labels
    release_version = var.release_version
    version         = var.kubernetes_version

    dynamic "remote_access" {
        for_each = length(var.remote_access) == 0 ? [] : [{
            ec2_ssh_key               = each.value["ec2_ssh_key"]
            source_security_group_ids = lookup(each.value, "source_security_group_ids", [])
        }]
        
        content {
            ec2_ssh_key               = remote_access.value["ec2_ssh_key"]
            source_security_group_ids = remote_access.value["source_security_group_ids"]
        }
    }

    tags = merge(
        var.tags,
        {"Name" = var.node_group_name}
    )

    lifecycle {
        ignore_changes        = [scaling_config.0.desired_size]
    }
    
    depends_on = [
        aws_iam_role_policy_attachment.main_AmazonEKSWorkerNodePolicy,
        aws_iam_role_policy_attachment.main_AmazonEKS_CNI_Policy,
        aws_iam_role_policy_attachment.main_AmazonEC2ContainerRegistryReadOnly,
    ]
}

# IAM

resource "aws_iam_role" "main" {
    count = var.node_role_arn == "" ? 1 : 0

    name                  = format("%s-eks-%s-node-group-role", var.cluster_name, var.node_group_name)
    assume_role_policy    = data.aws_iam_policy_document.main_assume_role_policy.json
    description           = format("Role for %s node group in the %s EKS cluster.", var.node_group_name, var.cluster_name)
    force_detach_policies = var.iam_role_force_detach_policies
    path                  = var.iam_role_path
    permissions_boundary  = var.iam_role_permissions_boundary

    tags = merge(
        var.tags,
        {"Name" = format("%s-eks-%s-node-group-role", var.cluster_name, var.node_group_name)}
    )
}

data "aws_iam_policy_document" "main_assume_role_policy" {
    statement {
        actions = [
            "sts:AssumeRole",
        ]
        effect = "Allow"
        principals {
            type        = "Service"
            identifiers = ["ec2.amazonaws.com"]
        }
    }
}

resource "aws_iam_role_policy_attachment" "main_AmazonEKSWorkerNodePolicy" {
    count = var.node_role_arn == "" ? 1 : 0

    role       = aws_iam_role.main[0].name
    policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
}

resource "aws_iam_role_policy_attachment" "main_AmazonEKS_CNI_Policy" {
    count = var.node_role_arn == "" ? 1 : 0

    role       = aws_iam_role.main[0].name
    policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
}

resource "aws_iam_role_policy_attachment" "main_AmazonEC2ContainerRegistryReadOnly" {
    count = var.node_role_arn == "" ? 1 : 0

    role       = aws_iam_role.main[0].name
    policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}

resource "aws_iam_role_policy_attachment" "main_additional_policies" {
    count = var.node_role_arn == "" ? length(var.iam_role_additional_policies) : 0

    role       = aws_iam_role.main[0].name
    policy_arn = element(var.iam_role_additional_policies, count.index)
}

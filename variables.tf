variable "cluster_name" {
    type        = string
    description = "Name of the EKS Cluster."
}

variable "node_group_name" {
    type        = string
    description = "Name of the EKS Node Group."
}

variable "node_role_arn" {
    type        = string
    default     = ""
    description = "Amazon Resource Name (ARN) of the IAM Role that provides permissions for the EKS Node Group."
}

variable "subnet_ids" {
    type        = list(string)
    description = "Identifiers of EC2 Subnets to associate with the EKS Node Group. These subnets must have the following resource tag: kubernetes.io/cluster/CLUSTER_NAME (where CLUSTER_NAME is replaced with the name of the EKS Cluster)."
}

variable "desired_size" {
    type        = number
    default     = 1
    description = "Desired number of worker nodes."
}

variable "max_size" {
    type        = number
    default     = 1
    description = "Maximum number of worker nodes."
}

variable "min_size" {
    type        = number
    default     = 1
    description = "Minimum number of worker nodes."
}

variable "ami_type" {
    type        = string
    default     = null
    description = "Type of Amazon Machine Image (AMI) associated with the EKS Node Group. Defaults to AL2_x86_64. Valid values: AL2_x86_64, AL2_x86_64_GPU."
}

variable "disk_size" {
    type        = number
    default     = null
    description = "Disk size in GiB for worker nodes."
}

variable "instance_types" {
    type        = list(string)
    default     = ["t3.medium"]
    description = "Set of instance types associated with the EKS Node Group."
}

variable "labels" {
    type        = map(string)
    default     = {}
    description = "Key-value mapping of Kubernetes labels."
}

variable "release_version" {
    type        = string
    default     = null
    description = "AMI version of the EKS Node Group. Defaults to latest version for Kubernetes version."
}

variable "tags" {
    type        = map(string)
    default     = {}
    description = "Key-value mapping of default tags for all IAM users."
}

variable "kubernetes_version" {
    type        = string
    default     = null
    description = "Kubernetes version. Defaults to EKS Cluster Kubernetes version. "
}

# IAM

variable "iam_role_force_detach_policies" {
    type        = bool
    default     = true
    description = "Specifies to force detaching any policies the role has before destroying it."
}

variable "iam_role_path" {
    type        = string
    default     = "/"
    description = "Path in which to create the group."
}

variable "iam_role_permissions_boundary" {
    type        = string
    default     = ""
    description = "The ARN of the policy that is used to set the permissions boundary for the role."
}

variable "iam_role_additional_policies" {
    type        = list(string)
    default     = []
    description = "The ARNs of the policies to attach to the role. Following policies are already attached: AmazonEKSWorkerNodePolicy, AmazonEKS_CNI_Policy and AmazonEC2ContainerRegistryReadOnly."
}

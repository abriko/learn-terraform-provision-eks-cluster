variable "region" {
  default     = "us-east-2"
  description = "AWS region"
}

variable "project_name" {
  default     = "training"
  description = "Project name"
}

# https://docs.aws.amazon.com/eks/latest/userguide/kubernetes-versions.html
variable "eks_version" {
  default     = 1.17
  type        = number
  description = "EKS cluster version"
}

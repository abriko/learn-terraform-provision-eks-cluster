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

variable "sg_ingress_rules" {
    type = list(object({
      from_port   = number
      to_port     = number
      protocol    = string
      cidr_block  = list(string)
      description = string
    }))
    default     = [
        {
          from_port   = 80
          to_port     = 80
          protocol    = "tcp"
          cidr_block  = ["0.0.0.0/0"]
          description = "http"
        },
        {
          from_port   = 443
          to_port     = 443
          protocol    = "tcp"
          cidr_block  = ["0.0.0.0/0"]
          description = "https"
        },
    ]
}
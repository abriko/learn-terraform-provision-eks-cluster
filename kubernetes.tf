# # Kubernetes provider
# # https://learn.hashicorp.com/terraform/kubernetes/provision-eks-cluster#optional-configure-terraform-kubernetes-provider
# # To learn how to schedule deployments and services using the provider, go here: https://learn.hashicorp.com/terraform/kubernetes/deploy-nginx-kubernetes

provider "kubernetes" {
  load_config_file       = "false"
  host                   = data.aws_eks_cluster.cluster.endpoint
  token                  = data.aws_eks_cluster_auth.cluster.token
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
}

resource "kubernetes_namespace" "cattle-system" {
  metadata {
    name = "cattle-system"
  }
}

provider "helm" {
  kubernetes {
    load_config_file       = "false"
    host                   = data.aws_eks_cluster.cluster.endpoint
    token                  = data.aws_eks_cluster_auth.cluster.token
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
  }
}

resource "helm_release" "rancher-server" {
  name  = "rancher"
  chart = "rancher-latest/rancher"
  repository = "https://releases.rancher.com/server-charts/latest"
  namespace = "cattle-system"

  set {
    name  = "hostname"
    value = data.aws_eks_cluster.cluster.endpoint
  }
}

provider "kubernetes" {
  host                   = aws_eks_cluster.demo.endpoint
  cluster_ca_certificate = base64decode(aws_eks_cluster.demo.certificate_authority[0].data)

  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    command     = "aws"
    args        = ["eks", "get-token", "--cluster-name", "demo"]
  }
}

resource "kubernetes_namespace" "tfco" {
  metadata {
    name = "tfco"
  }
}

resource "kubernetes_namespace" "agent" {
  metadata {
    name = "agent"
  }
}

provider "helm" {
  kubernetes {
    host                   = aws_eks_cluster.demo.endpoint
    cluster_ca_certificate = base64decode(aws_eks_cluster.demo.certificate_authority[0].data)

    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      command     = "aws"
      args        = ["eks", "get-token", "--cluster-name", "demo"]
    }
  }
}

resource "helm_release" "tfc-operator" {
  name      = "tfco"
  namespace = "tfco"

  repository = "https://helm.releases.hashicorp.com/"
  chart      = "terraform-cloud-operator"
  version    = "2.0.0-beta8"
}

locals {
  credentials = jsondecode( file("~/.terraform.d/credentials.tfrc.json") )
  token = local.credentials["credentials"]["app.terraform.io"]["token"]
}

resource "kubernetes_secret" "tfctoken" {
  metadata {
    name = "terraformrc"
    namespace = "agent"
  }

  data = {
    token = local.token
  }
}

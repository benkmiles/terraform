terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.20.0"
    }

    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.0.1"
    }

    helm={}
  }
}

provider "aws" {
  region = var.AWSRegion

}
data "aws_eks_cluster" "cluster" {
  name = var.EKSClusterName
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
  exec {
    api_version = "client.authentication.k8s.io/v1alpha1"
    command     = "aws"
    args = [
      "eks",
      "get-token",
      "--cluster-name",
      data.aws_eks_cluster.cluster.name
    ]
  }
}
provider "helm" {
  experiments {
    manifest = true
  }
  kubernetes {
    host                   = data.aws_eks_cluster.cluster.endpoint
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
    exec {
      api_version = "client.authentication.k8s.io/v1alpha1"
      command     = "aws"
      args = [
        "eks",
        "get-token",
        "--cluster-name",
        data.aws_eks_cluster.cluster.name
      ]
    }
  }
}
data "kubernetes_service" "socks-lb" {
  metadata {
    namespace = "socks"
    name = "front-end"
  }
}

//data "aws_lb" "lb" {
 // tags = {"kubernetes.io/service-name" = "socks/front-end"}
 // name = "tset" //data.kubernetes_service.socks-lb.status[0].load_balancer[0].ingress[0].hostname
  //for_each = var.subnets
 
 // filter {
  //  name   = "association.public-dns-name"
  //  values = ["a472d619b04ac455db3e8f9c761251ab-2008082668.us-west-1.elb.amazonaws.com"]
 //}
 //filter {
 //  name = "tag:kubernetes.io/service-name"
  //  values = ["socks/front-end"]
//}
 // filter {
 //   name   = "subnet-id"
  //  values = [each.value]
 // }
//}

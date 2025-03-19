terraform {
  required_version = "1.11.2"
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 5.91.0"
    }
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "~> 2.36.0"
    }
    kubectl = {
      source = "gavinbunney/kubectl"
      version = "~> 1.19.0"
    }
    helm = {
      source = "hashicorp/helm"
      version = "~> 2.17.0"
    }
    cloudinit = {
      source = "hashicorp/cloudinit"
      version = "~> 2.3.6"
    }
  }
}
module "vpc" {
  source = "./modules/vpc"

  vpc_name = var.cluster_name
  vpc_cidr = var.vpc_cidr
}
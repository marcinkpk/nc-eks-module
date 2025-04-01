output "name_servers" {
  value = module.r53-acm.name_servers
}

output "vpc_id" {
  value = module.vpc.vpc_id
}

output "vpc_public_subnet_ids" {
  value = module.vpc.vpc_public_subnet_ids
}

output "vpc_private_subnet_ids" {
  value = module.vpc.vpc_private_subnet_ids
}
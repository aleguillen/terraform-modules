output "vnet_id" {
  value = module.network.vnet.id
}

output "subnets_id" {
  value = module.network.subnets.*.id
}

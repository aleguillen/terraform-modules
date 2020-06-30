locals {
    vnet_address_spaces = length(var.vnet_address_spaces) > 0 ? var.vnet_address_spaces : [ var.vnet_address_space ]
    
    subnets = length(var.vnet_subnets_names) > 0 ? [for s in var.vnet_subnets_names : {
        name = s
        address_prefix = cidrsubnet(
            var.vnet_address_space,
            var.vnet_subnets_newbits,
            var.vnet_subnets_netnum + index(var.vnet_subnets_names, s),
        )
        enforce_private_link_endpoint_network_policies = var.vnet_subnets_enforce_private_link_endpoint_network_policies
        enforce_private_link_service_network_policies = var.vnet_subnets_enforce_private_link_service_network_policies
        service_endpoints = var.vnet_subnet_service_endpoints
        delegations = var.vnet_subnet_delegations
    }] : var.vnet_subnets
}

data "azurerm_resource_group" "this" {
  name = var.resource_group_name
}

# CREATE: DDoS Protection Plan 
# IF: vnet_ddos_protection_plan_name variable is not null or empty
resource "azurerm_network_ddos_protection_plan" "this" {
  count = length(var.vnet_ddos_protection_plan_name) > 0 ? 1 : 0

  name                = var.vnet_ddos_protection_plan_name
  resource_group_name = data.azurerm_resource_group.this.name
  location            = var.location

  tags                = var.tags
}

# CREATE: Virtual Network
# IF: is_new variable is set to TRUE.
resource "azurerm_virtual_network" "this" {
  count = var.is_new ? 1 : 0

  name                = var.virtual_network_name
  resource_group_name = data.azurerm_resource_group.this.name
  location            = var.location

  address_space       = local.vnet_address_spaces
  dns_servers         = length(var.vnet_dns_servers) > 0 ? var.vnet_dns_servers : null

  dynamic "ddos_protection_plan" {
    for_each = length(var.vnet_ddos_protection_plan_name) > 0 ? [azurerm_network_ddos_protection_plan.this.0.id] : []
    content {
      id     = azurerm_network_ddos_protection_plan.this.0.id
      enable = true
    }
  }

  tags = var.tags
}

# GET: Virtual Network (new or existent)
data "azurerm_virtual_network" "this" {
  name                = var.is_new ? azurerm_virtual_network.this.0.name : var.virtual_network_name
  resource_group_name = data.azurerm_resource_group.this.name
}

# CREATE: Subnets
resource "azurerm_subnet" "this" {
  count = var.is_new && length(local.subnets) > 0 ? length(local.subnets) : 0

  name                 = local.subnets[count.index].name
  resource_group_name  = data.azurerm_resource_group.this.name
  virtual_network_name = data.azurerm_virtual_network.this.name
  
  address_prefixes = [ local.subnets[count.index].address_prefix ]
  
  enforce_private_link_endpoint_network_policies = local.subnets[count.index].enforce_private_link_endpoint_network_policies
  enforce_private_link_service_network_policies = local.subnets[count.index].enforce_private_link_service_network_policies

  service_endpoints = length(local.subnets[count.index].service_endpoints) > 0 ? local.subnets[count.index].service_endpoints : null

  dynamic "delegation" {
    for_each = local.subnets[count.index].delegations 

    content {
      name = local.subnets[count.index].delegations.name
      
      dynamic "service_delegation" {
        for_each = local.subnets[count.index].delegations.service_delegation
          
        content {
          name    = local.subnets[count.index].delegations.service_delegation.name
          actions = local.subnets[count.index].delegations.service_delegation.actions
        }
      }
    }
  }

}

data "azurerm_subnet" "this" {
  count = length(local.subnets) 

  name                 = var.is_new ? azurerm_subnet.this[count.index].name : local.subnets[count.index].name
  virtual_network_name = data.azurerm_virtual_network.this.name
  resource_group_name  = data.azurerm_resource_group.this.name
}
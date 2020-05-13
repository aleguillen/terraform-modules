resource "azurerm_resource_group" "test" {
  name     = var.resource_group_name
  location = var.location
}

module "network" {
  source              = "github.com/aleguillen/terraform-modules/azure/network/vnet"
  resource_group_name   = azurerm_resource_group.test.name
  location              = azurerm_resource_group.test.location
  virtual_network_name  = var.virtual_network_name

  vnet_address_space    = "10.0.0.0/16"
  vnet_subnets_names        = ["subnet1", "subnet2", "subnet3"]
  vnet_subnets_enforce_private_link_endpoint_network_policies = true

  tags = local.tags
}

resource "azurerm_resource_group" "test" {
  name     = var.resource_group_name
  location = var.location
}

module "network" {
  source              = "github.com/aleguillen/terraform-modules/azure/network/vnet"

  resource_group_name   = azurerm_resource_group.test.name
  location              = azurerm_resource_group.test.location
  virtual_network_name  = var.virtual_network_name

  vnet_address_spaces   = ["10.0.0.0/16"]
  vnet_subnets          = local.subnets

  tags = local.tags
}

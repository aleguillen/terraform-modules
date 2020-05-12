# azure/network/vnet

## Create a basic network in Azure

This Terraform module deploys a Virtual Network in Azure with a set of subnets passed in as input parameters.

The module does not create nor expose a security group. 

## Example Simple Configuration
```hcl
resource "azurerm_resource_group" "test" {
  name     = "my-resource-group"
  location = "southcentralus"
}

module "network" {
  source              = "github.com/aleguillen/azure/network/vnet"

  resource_group_name   = azurerm_resource_group.test.name
  location              = azurerm_resource_group.test.location
  virtual_network_name  = "my-vnet"

  vnet_address_space    = "10.0.0.0/16"
  vnet_subnets_names        = ["subnet1", "subnet2", "subnet3"]
  vnet_subnets_enforce_private_link_endpoint_network_policies = true

  tags = {
    environment = "dev"
    costcenter  = "1234"
  }
}
```

## Example Complex Configuration
```hcl
resource "azurerm_resource_group" "test" {
  name     = "my-resource-group"
  location = "southcentralus"
}

module "network" {
  source              = "github.com/aleguillen/azure/network/vnet"

  resource_group_name   = azurerm_resource_group.test.name
  location              = azurerm_resource_group.test.location
  virtual_network_name  = "my-vnet"

  vnet_address_spaces   = ["10.0.0.0/16"]
  vnet_subnets          = [
      {
        name = "subnet1"
        address_prefix = "10.0.1.0/24"
        enforce_private_link_endpoint_network_policies = true
        enforce_private_link_service_network_policies = false
        service_endpoints = []
      },
      {
        name = "subnet2"
        address_prefix = "10.0.2.0/24"
        enforce_private_link_endpoint_network_policies = false
        enforce_private_link_service_network_policies = false
        service_endpoints = []
      },
      {
        name = "subnet3"
        address_prefix = "10.0.3.0/24"
        enforce_private_link_endpoint_network_policies = false
        enforce_private_link_service_network_policies = false
        service_endpoints = []
      }
  ]

  tags = {
    environment = "dev"
    costcenter  = "1234"
  }
}

```

## Authors

Originally created by [Alejandra Guillen](http://github.com/aleguillen)

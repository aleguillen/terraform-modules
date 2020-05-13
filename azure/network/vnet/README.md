# azure/network/vnet

## Create a basic network in Azure

This Terraform module deploys a Virtual Network in Azure with a set of subnets passed in as input parameters.

The module does not create nor expose a security group. 

## Example Usage
```hcl
resource "azurerm_resource_group" "test" {
  name     = "my-resource-group"
  location = "southcentralus"
}

module "network" {
  source              = "github.com/aleguillen/terraform-modules/azure/network/vnet"

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

output "vnet_id" {
  value = module.network.vnet.id
}

output "subnet_ids" {
  value = module.network.subnets.*.id
}

```

## Variables
| Name | Type | Description |
| -- | -- | -- |
| resource_group_name | string | (Required) The name of the resource group in which to create the subnet. | 
| virtual_network_name | string | (Required) The name of the virtual network to which to attach the subnet. | 
| location | string | (Required) The location/region where the virtual network is created. | 
| is_new | bool | (Optional) Determines if VNET is new or existing. Defaults to true |
| tags | map(string) | (Optional) A mapping of tags to assign to the resource. Defaults to {} | 
| vnet_ddos_protection_plan_name | string | (Optional) DDoS Protection Plan name. If specified it will create and enable DDoS Protection Plan on Virtual Network. Defaults to empty string | 
| vnet_dns_servers | list(string) | (Optional) List of IP addresses of DNS servers. Defaults to [] | 

### Simple Subnet Variables
Either use Simple Subnet variables or complex variables. 

| Name | Type | Description |
| -- | -- | -- |
| vnet_address_space | string | (Optional) The address space that is used the virtual network. Defaults to empty string. Required if using Simple Subnet Variables. | 
| vnet_subnets_names | list(string) | (Optional) The list of of subnets in the VNet. Defaults to []. Required if using Simple Subnet Variables. | 
| vnet_subnets_newbits | number | (Optional) The newbits for the specified Subnets. Ex. cidrsubnet('10.0.0.0/16',8,0) = 10.0.0.0/24. Defaults to 8. | 
| vnet_subnets_netnum | number | (Optional) The netnum for the specified Subnets. Ex. cidrsubnet('10.0.0.0/16',8,1) = 10.0.1.0/24. Defaults to 0. | 
| vnet_subnets_enforce_private_link_service_network_policies | bool | (Optional) Enable or Disable network policies for the private link service on the subnet. Default valule is false. Conflicts with enforce_private_link_endpoint_network_policies. Defaults to false. | 
| vnet_subnets_enforce_private_link_endpoint_network_policies | bool | (Optional) Enable or Disable network policies for the private link endpoint on the subnet. Default value is false. Conflicts with enforce_private_link_service_network_policies. Defaults to false. | 
| vnet_subnet_service_endpoints | list(string) | (Optional) The list of Service endpoints to associate with the subnet. Possible values include: Microsoft.AzureActiveDirectory, Microsoft.AzureCosmosDB, Microsoft.ContainerRegistry, Microsoft.EventHub, Microsoft.KeyVault, Microsoft.ServiceBus, Microsoft.Sql, Microsoft.Storage and Microsoft.Web. Defaults to []. | 

### Complex Subnet Variables
Either use Simple Subnet variables or complex. Follo
| Name | Type | Description |
| -- | -- | -- |
| vnet_address_spaces | list(string) | (Optional) The address spaces that is used the virtual network. You can supply more than one address space. Defaults to []. Required if using Complex Subnet Variables. | 
| [vnet_subnets](####vnet_subnets-object) | list(object) | (Optional) The list of of subnets in the VNet. Defaults to [] | 

#### vnet_subnets object
| Name | Type | Description |
| -- | -- | -- |
| name | string | (Required) Subnet Name. |
| address_prefix | string | (Required) The address space that is used the Subnet. |
| enforce_private_link_endpoint_network_policies | bool | (Required) Enable or Disable network policies for the private link endpoint on the subnet. |
| enforce_private_link_service_network_policies | bool | (Required) Enable or Disable network policies for the private link service on the subnet.  |
| service_endpoints | list(string) | (Required) The list of Service endpoints to associate with the subnet. Possible values include: Microsoft.AzureActiveDirectory, Microsoft.AzureCosmosDB, Microsoft.ContainerRegistry, Microsoft.EventHub, Microsoft.KeyVault, Microsoft.ServiceBus, Microsoft.Sql, Microsoft.Storage and Microsoft.Web. Allows empty list: [] |

## Outputs
| Name | Type | Description |
| --   | -- |
| vnet | Returns the Virtual Network object | 
| subnets | Returns a list of Subnet objects | 

## Authors

Originally created by [Alejandra Guillen](http://github.com/aleguillen)

## License

[MIT](LICENSE)
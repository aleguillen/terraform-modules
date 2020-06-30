
variable "resource_group_name" {
  type        = string
  description = "(Required) The name of the resource group in which to create the subnet."
}

variable "virtual_network_name" {
  type        = string
  description = "(Required) The name of the virtual network to which to attach the subnet."
}

variable "location" {
  type        = string
  description = "(Required) The location/region where the virtual network is created."
}

variable "is_new" {
    type = bool
    description = "(Optional) Determines if VNET is new or existing."
    default = true
}

variable "tags" {
  type        = map(string)
  description = "(Optional) A mapping of tags to assign to the resource."
  default     = {}
}

variable "vnet_ddos_protection_plan_name" {
  type        = string
  description = "(Optional) DDoS Protection Plan name. If specified it will create and enable DDoS Protection Plan on Virtual Network"
  default     = ""
}

variable "vnet_dns_servers" {
  type        = list(string)
  description = "(Optional) List of IP addresses of DNS servers"
  default     = []
}

################################
# Simple Subnets Configuration #
################################
variable "vnet_address_space" {
  type        = string
  description = "(Optional) The address space that is used the virtual network."
  default     = ""
}

variable "vnet_subnets_names" {
  type        = list(string)
  description = "(Optional) The list of of subnets in the VNet."
  default = [

  ]
}

variable "vnet_subnets_newbits" {
  type        = number
  description = "(Optional) The newbits for the specified Subnets. Ex. cidrsubnet('10.0.0.0/16',8,0) = 10.0.0.0/24"
  default     = 8
}

variable "vnet_subnets_netnum" {
  type        = number
  description = "(Optional) The netnum for the specified Subnets. Ex. cidrsubnet('10.0.0.0/16',8,1) = 10.0.1.0/24"
  default     = 0
}

variable "vnet_subnets_enforce_private_link_service_network_policies" {
  type        = bool
  description = "(Optional) Enable or Disable network policies for the private link service on the subnet. Default valule is false. Conflicts with enforce_private_link_endpoint_network_policies."
  default     = false
}

variable "vnet_subnets_enforce_private_link_endpoint_network_policies" {
  type        = bool
  description = "(Optional) Enable or Disable network policies for the private link endpoint on the subnet. Default value is false. Conflicts with enforce_private_link_service_network_policies."
  default     = false
}

variable "vnet_subnet_service_endpoints" {
  type        = list(string)
  description = "(Optional) The list of Service endpoints to associate with the subnet. Possible values include: Microsoft.AzureActiveDirectory, Microsoft.AzureCosmosDB, Microsoft.ContainerRegistry, Microsoft.EventHub, Microsoft.KeyVault, Microsoft.ServiceBus, Microsoft.Sql, Microsoft.Storage and Microsoft.Web."
  default = []
}

variable "vnet_subnet_delegations" {
  type        = list(object({
    name = string
    service_delegation = object({
      name = string
      actions = list(string)
    })
  }))
  description = "(Optional) One or more delegation blocks as defined below."
  default = []
}

#################################
# Complex Subnets Configuration #
#################################

variable "vnet_address_spaces" {
  type        = list(string)
  description = "(Optional) The address spaces that is used the virtual network. You can supply more than one address space."
  default     = []
}

variable "vnet_subnets" {
  type        = list(object({
    name = string
    address_prefix = string
    enforce_private_link_endpoint_network_policies = bool
    enforce_private_link_service_network_policies = bool
    service_endpoints = list(string)
    delegations = list(object({
      name = string
      service_delegation = object({
        name = string
        actions = list(string)
      })
    }))
  }))
  description = "(Optional) The list of of subnets in the VNet."
  default = []
}
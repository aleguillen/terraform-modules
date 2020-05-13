variable "resource_group_name" {
  type        = string
  description = "(Required) The name of the resource group in which to create the subnet."
  default     = "my-resource-group"
}

variable "virtual_network_name" {
  type        = string
  description = "(Required) The name of the virtual network to which to attach the subnet."
  default     = "my-vnet"
}

variable "location" {
  type        = string
  description = "(Required) The location/region where the virtual network is created."
  default     = "southcentralus"
}
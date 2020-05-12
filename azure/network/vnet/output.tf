output "vnet" {
  value = "${data.azurerm_virtual_network.this}"
}

output "subnets" {
  value = "${data.azurerm_subnet.this.*}"
}
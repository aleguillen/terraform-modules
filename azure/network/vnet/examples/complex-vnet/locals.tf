locals {
    tags = {
        environment = "dev"
        costcenter  = "1234"
    }

    subnets = [
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
}
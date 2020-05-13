# Azure Complex Virtual Network test

Creates a prefined Virtual Network structure, subnets address spaces must be defined in the input variables.

## Usage
To run this example, simply execute: 

```hcl
terraform init
terraform plan
terraform apply
```

Once you are done, just run 
```hcl
terraform destroy
```

## Outputs
| Name | Description |
| --   | -- |
| vnet_id | Returns the id of Virtual Network | 
| subnets_id | Returns a list of Subnet's id | 

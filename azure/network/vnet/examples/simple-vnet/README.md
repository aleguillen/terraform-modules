# Azure Simple Virtual Network test

Creates a quick and simple Virtual Network structure, creates Subnets Address Spaces /24 by default.

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

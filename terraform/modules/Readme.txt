Directory tree of root and children modules:

├── [terraform]
|   ├── main.tf
|   ├── variables.tf
|   ├── outputs.tf
|   ├── versions.tf
|   ├── terraform.tfvars
|   |
|   ├── [modules]
|   |   |
|   │   ├── [ebe]
|   │   │   ├── main.tf
│   |   │   ├── variables.tf
│   │   |   └── outputs.tf
|   │   ├── [eba]
|   │   │   ├── main.tf
|   │   │   ├── variables.tf
|   │   │   └── outputs.tf
|   │   ├── [vpc]
|   │   │   ├── main.tf
|   │   │   ├── variables.tf
|   │   │   └── outputs.tf
|   │   ├── [subnets]
|   │   │   ├── main.tf
|   │   │   ├── variables.tf
|   │   │   ├── context.tf
|   │   │   ├── nat-gateway.tf
|   │   │   ├── nat-instance.tf
|   │   │   ├── private.tf
|   │   │   ├── public.tf
|   │   │   └── outputs.tf
|   │   ├── [label]
|   │   │   ├── main.tf
|   │   │   ├── variables.tf
|   │   │   └── outputs.tf
|   │   ├── [dnshost]
|   │   │   ├── main.tf
|   │   │   ├── context.tf
|   │   │   ├── variables.tf
|   │   │   └── outputs.tf
|   │   ├── [utilities]
|   │   │   ├── main.tf
|   │   │   ├── context.tf
|   │   │   ├── variables.tf
|   │   │   └── outputs.tf

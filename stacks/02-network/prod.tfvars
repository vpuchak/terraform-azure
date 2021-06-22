env = "prod"

address_spaces = ["10.1.0.0/16"]
subnets = [
  {
    name           = "subnet1"
    address_prefix = "10.1.1.0/24"
  },
  {
    name           = "subnet2"
    address_prefix = "10.1.2.0/24"
  },
]

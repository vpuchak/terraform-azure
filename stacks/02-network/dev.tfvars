env = "dev"

address_spaces = ["10.0.0.0/16"]
subnets        = [
  {
    name           = "subnet1"
    address_prefix = "10.0.1.0/24"
  },
  {
    name           = "subnet2"
    address_prefix = "10.0.2.0/24"
  },
]

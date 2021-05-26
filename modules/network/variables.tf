variable "vnet_name" {
  description = "Name of the vnet to create."
  type        = string
  default     = "acctvnet"
}

variable "resource_group_name" {
  description = "The name of an existing resource group to be imported."
  type        = string
}

variable "address_spaces" {
  description = "The list of the address spaces that is used by the virtual network."
  type        = list(string)
  default     = []
}

# If no values specified, this defaults to Azure DNS
variable "dns_servers" {
  description = "The DNS servers to be used with vNet."
  type        = list(string)
  default     = []
}

variable "subnets" {
  description = "The address prefix to use for the subnet."
  type        = list(map(string))
  default     = []
}

variable "tags" {
  description = "The tags to associate with your network and subnets."
  type        = map(string)

  default = {
    environment = "dev"
  }
}

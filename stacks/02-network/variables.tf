variable "env" {
  description = "Environment name"
  default     = ""
}

variable "region" {
  description = "Azure region"
  default     = "westus2"
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

variable "create_vm" {
  description = "Flag to create VM"
  default     = false
}

variable "vm_size" {
  description = "The size for the VM"
  default     = "Standard_DS1_v2"
}
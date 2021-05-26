variable "env" {
  description = "Environment name"
  default     = ""
}

variable "region" {
  description = "Azure region"
  default     = "westus2"
}

variable "create_vm" {
  description = "Flag to create VM"
  default     = false
}

variable "vm_size" {
  description = "The size for the VM"
  default     = "Standard_DS1_v2"
}

variable "azurerm_key_vault_name" {
  description = "The name of the Key Vault with secrets"
  default     = ""
}

variable "azurerm_key_vault_rg_name" {
  description = "The name of the Resource Group in which the Key Vault exists"
  default     = ""
}

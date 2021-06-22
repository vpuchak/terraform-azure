variable "env" {
  description = "Environment name"
  default     = ""
}

variable "location" {
  description = "Azure location"
  default     = "eastus"
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

variable "extra_ssh_keys" {
  description = "Same as ssh_key, but allows for setting multiple public keys. Set your first key in ssh_key, and the extras here."
  type        = list(string)
  default     = []
}

variable "ssh_key" {
  description = "Path to the public key to be used for ssh access to the VM. Only used with non-Windows vms and can be left as-is even if using Windows vms. If specifying a path to a certification on a Windows machine to provision a linux vm use the / in the path versus backslash. e.g. c:/home/id_rsa.pub."
  type        = string
  default     = "~/.ssh/id_rsa.pub"
}

variable "ssh_key_values" {
  description = "List of Public SSH Keys values to be used for ssh access to the VMs."
  type        = list(string)
  default     = []
}

variable "enable_ssh_key" {
  type        = bool
  description = "(Optional) Enable ssh key authentication in Linux virtual Machine."
  default     = true
}

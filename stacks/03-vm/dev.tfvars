env       = "dev"
create_vm = true
vm_size   = "Standard_DS1_v2"

azurerm_key_vault_rg_name = "secrets"
azurerm_key_vault_name    = "dev-vm"

enable_ssh_key = true
ssh_key_values = [
  "ssh-rsa AAAAB3NzaC1yc2E...."
]

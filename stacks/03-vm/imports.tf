data "terraform_remote_state" "rg" {
  backend = "azurerm"
  config  = {
    storage_account_name = "tstate09762"
    container_name       = "tstate"
    key                  = "rg.terraform.tfstate"
  }
}

data "terraform_remote_state" "network" {
  backend = "azurerm"
  config  = {
    storage_account_name = "tstate09762"
    container_name       = "tstate"
    key                  = "network.terraform.tfstate"
  }
}

data "azurerm_key_vault" "main" {
  name                = var.azurerm_key_vault_name
  resource_group_name = var.azurerm_key_vault_rg_name
}

data "azurerm_key_vault_secret" "admin_username" {
  name         = "admin_username"
  key_vault_id = data.azurerm_key_vault.main.id
}

data "azurerm_key_vault_secret" "admin_password" {
  name         = "admin_password"
  key_vault_id = data.azurerm_key_vault.main.id
}

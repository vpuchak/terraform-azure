data "terraform_remote_state" "rg" {
  backend   = "azurerm"
  workspace = terraform.workspace

  config = {
    resource_group_name  = "tstate"
    storage_account_name = "tstate097624"
    container_name       = "tstate"
    key                  = "rg.terraform.tfstate"
  }
}

data "terraform_remote_state" "network" {
  backend   = "azurerm"
  workspace = terraform.workspace

  config = {
    resource_group_name  = "tstate"
    storage_account_name = "tstate097624"
    container_name       = "tstate"
    key                  = "network.terraform.tfstate"
  }
}

data "azurerm_key_vault" "main" {
  name                = var.azurerm_key_vault_name
  resource_group_name = var.azurerm_key_vault_rg_name
}

data "azurerm_key_vault_secret" "admin_username" {
  name         = "admin-username"
  key_vault_id = data.azurerm_key_vault.main.id
}

data "azurerm_key_vault_secret" "admin_password" {
  name         = "admin-password"
  key_vault_id = data.azurerm_key_vault.main.id
}

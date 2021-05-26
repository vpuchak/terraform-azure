data "terraform_remote_state" "rg" {
  backend = "azurerm"
  config  = {
    storage_account_name  = "tstate09762"
    container_name        = "tstate"
    key                  = "prod.terraform.tfstate"
  }
}

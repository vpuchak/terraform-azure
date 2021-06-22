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

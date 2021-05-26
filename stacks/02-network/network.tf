# https://learn.hashicorp.com/tutorials/terraform/azure-dependency?in=terraform/azure-get-started

module "network" {
  source              = "../modules/network"
  resource_group_name = data.terraform_remote_state.rg.resource_group_id

  address_spaces      = var.address_spaces

  subnets = var.subnets

  tags = {
    environment = "dev"
    costcenter  = "it"
  }

  # depends_on = [azurerm_resource_group.example]
}

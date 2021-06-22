# https://learn.hashicorp.com/tutorials/terraform/azure-dependency?in=terraform/azure-get-started

module "network" {
  source              = "../../modules/network"
  resource_group_name = data.terraform_remote_state.rg.outputs.resource_group_name
  address_spaces      = var.address_spaces
  subnets             = var.subnets

  tags = local.tags
}

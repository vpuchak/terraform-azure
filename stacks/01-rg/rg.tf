resource "azurerm_resource_group" "rg" {
  name     = "${var.env}-resource-group"
  location = var.location

  tags = local.tags
}

resource "azurerm_resource_group" "rg2" {
  for_each = {
    a_group       = "eastus"
    another_group = "westus2"
  }
  name     = each.key
  location = each.value

  tags = local.tags
}

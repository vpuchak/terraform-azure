resource "azurerm_resource_group" "rg" {
  name     = "${var.env}-resource-group"
  location = var.region

  tags = local.tags
}

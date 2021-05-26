data "azurerm_resource_group" "network" {
  name = var.resource_group_name
}

resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  resource_group_name = data.azurerm_resource_group.network.name
  location            = data.azurerm_resource_group.network.location
  address_space       = var.address_spaces
  dns_servers         = var.dns_servers
  tags                = var.tags
}

resource "azurerm_subnet" "subnet" {
  count                                          = length(var.subnets)
  name                                           = lookup(var.subnets[count.index], "name", null)
  resource_group_name                            = data.azurerm_resource_group.network.name
  address_prefixes                               = lookup(var.subnets[count.index], "address_prefixes", null)
  virtual_network_name                           = azurerm_virtual_network.vnet.name
  enforce_private_link_endpoint_network_policies = lookup(var.subnets[count.index], "enforce_private_link_endpoint_network_policies", null)
}

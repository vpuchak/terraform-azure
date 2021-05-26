# Create Network Security Group and rule
resource "azurerm_network_security_group" "nsg" {
  count               = var.create_vm ? 1 : 0
  name                = "${var.env}-nsg"
  location            = var.region
  resource_group_name = data.terraform_remote_state.rg.resource_group_name

  security_rule {
    name                       = "SSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

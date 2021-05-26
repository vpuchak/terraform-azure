# Create public IP
resource "azurerm_public_ip" "publicip" {
  count               = var.create_vm ? 1 : 0
  name                = "${var.env}-public-ip"
  location            = var.region
  resource_group_name = data.terraform_remote_state.rg.resource_group_name
  allocation_method   = "Static"
}

# Create network interface
resource "azurerm_network_interface" "nic" {
  count               = var.create_vm ? 1 : 0
  name                = "${var.env}-nic"
  location            = var.region
  resource_group_name = data.terraform_remote_state.rg.resource_group_name

  ip_configuration {
    name                          = "${var.env}-nic-config"
    subnet_id                     = data.terraform_remote_state.network.vnet_subnets[0]
    private_ip_address_allocation = "dynamic"
    public_ip_address_id          = azurerm_public_ip.publicip.id
  }
}

# Create a Linux virtual machine
resource "azurerm_virtual_machine" "vm" {
  count                 = var.create_vm ? 1 : 0
  name                  = "${var.env}-vm"
  location              = var.region
  resource_group_name   = data.terraform_remote_state.rg.resource_group_name
  network_interface_ids = [azurerm_network_interface.nic.id]
  vm_size               = var.vm_size

  storage_os_disk {
    name              = "myOsDisk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Premium_LRS"
  }

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04.0-LTS"
    version   = "latest"
  }

  os_profile {
    computer_name  = "myTFVM"
    admin_username = data.azurerm_key_vault_secret.admin_username.value
    admin_password = data.azurerm_key_vault_secret.admin_password.value
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }

  lifecycle {
    ignore_changes = [
      os_profile_linux_config, os_profile
    ]
  }
}

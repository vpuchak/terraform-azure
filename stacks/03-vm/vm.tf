# Create public IP
resource "azurerm_public_ip" "publicip" {
  count               = var.create_vm ? 1 : 0
  name                = "${var.env}-public-ip"
  location            = var.location
  resource_group_name = data.terraform_remote_state.rg.outputs.resource_group_name
  allocation_method   = "Static"
}

# Create network interface
resource "azurerm_network_interface" "nic" {
  count               = var.create_vm ? 1 : 0
  name                = "${var.env}-nic"
  location            = var.location
  resource_group_name = data.terraform_remote_state.rg.outputs.resource_group_name

  ip_configuration {
    name                          = "${var.env}-nic-config"
    subnet_id                     = data.terraform_remote_state.network.outputs.vnet_subnets[0]
    private_ip_address_allocation = "dynamic"
    public_ip_address_id          = azurerm_public_ip.publicip[count.index].id
  }
}

# Create a Linux virtual machine
resource "azurerm_virtual_machine" "vm" {
  count                 = var.create_vm ? 1 : 0
  name                  = "${var.env}-vm"
  location              = var.location
  resource_group_name   = data.terraform_remote_state.rg.outputs.resource_group_name
  network_interface_ids = [azurerm_network_interface.nic[count.index].id]
  vm_size               = var.vm_size

  storage_os_disk {
    name              = "${var.env}-vm-disc"
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
    disable_password_authentication = var.enable_ssh_key

    dynamic ssh_keys {
      for_each = var.enable_ssh_key ? local.ssh_keys : []
      content {
        path     = "/home/${data.azurerm_key_vault_secret.admin_username.value}/.ssh/authorized_keys"
        key_data = file(ssh_keys.value)
      }
    }

    dynamic ssh_keys {
      for_each = var.enable_ssh_key ? var.ssh_key_values : []
      content {
        path     = "/home/${data.azurerm_key_vault_secret.admin_username.value}/.ssh/authorized_keys"
        key_data = ssh_keys.value
      }
    }
  }

  lifecycle {
    ignore_changes = [
      os_profile_linux_config, os_profile
    ]
    create_before_destroy = true
  }

  depends_on = [
    azurerm_network_interface.nic,
  ]
}

resource "null_resource" "bastion_provisioner" {
  count                 = var.create_vm ? 1 : 0

  triggers = {
    vm_ids = join(",", azurerm_virtual_machine.vm.*.id)
  }

  depends_on = [azurerm_public_ip.publicip, azurerm_virtual_machine.vm]

  connection {
    type     = "ssh"
    host     = azurerm_public_ip.publicip[count.index].ip_address
    user     = data.azurerm_key_vault_secret.admin_username.value
    password = data.azurerm_key_vault_secret.admin_password.value
  }

  provisioner "file" {
    content     = "env name: ${terraform.workspace}"
    destination = "/tmp/file.log"
  }

  provisioner "file" {
    content     = templatefile("${path.module}/templates/backends.tpl", { port = 8080, ip_addrs = ["10.0.0.1", "10.0.0.2"] })
    destination = "/tmp/file2.log"
  }

  provisioner "file" {
    source      = "${path.module}/files/id_rsa.pub"
    destination = "/tmp/id_rsa.pub"
  }

  provisioner "remote-exec" {
    inline = [
      "cat /tmp/file.log",
      "cat /tmp/file2.log",
      "cat /tmp/id_rsa.pub"
    ]
  }

}

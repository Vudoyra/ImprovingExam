locals {
  number_of_disks = 2
}

resource "azurerm_virtual_machine" "adrianexam" {
  name                  = "${var.prefix}-vm"
  location              = azurerm_resource_group.rg.location
  resource_group_name   = azurerm_resource_group.rg.name
  network_interface_ids = ["${azurerm_network_interface.nic.id}"]
  vm_size               = "Standard_B1ms"

  # Para eliminar el disk cuando terraform destruya la maquina virtual
  delete_os_disk_on_termination = false

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  storage_os_disk {
    name              = "myosdisk1"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    computer_name  = "hostname"
    admin_username = "adrianadmin"
    admin_password = "Password1234!"
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }
}

resource "azurerm_managed_disk" "osdisk" {
  count                = local.number_of_disks
  name                 = "${var.prefix}-disk${count.index + 1}"
  location             = azurerm_resource_group.rg.location
  resource_group_name  = azurerm_resource_group.rg.name
  storage_account_type = "Standard_LRS"
  create_option        = "Empty"
  disk_size_gb         = "32"
}

resource "azurerm_virtual_machine_data_disk_attachment" "datadisk" {
  count              = local.number_of_disks
  managed_disk_id    = azurerm_managed_disk.osdisk.*.id[count.index]
  virtual_machine_id = azurerm_virtual_machine.adrianexam.id
  lun                = 10 + count.index
  caching            = "ReadWrite"
}
resource "azurerm_linux_virtual_machine" "jump_host" {
 
  name                = "${local.resource_name_prefix}-jumpvm"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  size                = "Standard_F2"
  admin_username      = "azureuser"
  #we will attach the nic card with vm
  network_interface_ids = [
    azurerm_network_interface.jump_nic.id,
  ]

  admin_ssh_key {
    username = "azureuser"
    #below mentioned is the path of our ssh public key
    public_key = file("${path.module}/ssh/terraform-azure.pub")
    #it will look for the file in current directory
    #cd ./
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
 
}
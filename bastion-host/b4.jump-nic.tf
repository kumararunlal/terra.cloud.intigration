resource "azurerm_network_interface" "jump_nic" {
  
  name                = "${local.resource_name_prefix}-nic-jump"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  #network interface card has ip configuration
  ip_configuration {
    name = "internal"
    #intenal will come from where 
    subnet_id                     = azurerm_subnet.jump_subnet.id
    private_ip_address_allocation = "Dynamic"
    #we need to attach the public ip
    public_ip_address_id = azurerm_public_ip.jump_public_ip.id
}
}
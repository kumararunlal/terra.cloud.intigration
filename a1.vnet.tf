resource "azurerm_virtual_network" "vnet" {
  name                = "${local.resource_name_prefix}-${var.vnet_name}"
  #sa-dev-vnet-ky
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = ["10.0.0.0/16"]
  
}


//
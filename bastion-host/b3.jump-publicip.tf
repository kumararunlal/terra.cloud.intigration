resource "azurerm_public_ip" "jump_public_ip" {
  name                = "${local.resource_name_prefix}-publicip-jump"

  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Static"
  sku = "Standard" #basic #premium
}
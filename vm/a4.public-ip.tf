resource "azurerm_public_ip" "web_public_ip" {
  for_each = var.car
  name                = "${local.resource_name_prefix}-publicip-${each.key}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Static"
  sku = "Standard" #basic #premium
}
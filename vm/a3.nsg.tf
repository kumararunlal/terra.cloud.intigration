##we created the nsg 
##it will create a firewall
resource "azurerm_network_security_group" "web_subnet_nsg" {
  name                = "${local.resource_name_prefix}-nsg"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}
#when you create this firewall this need to be attached with your subnet
#this nsg will be part of your subnet also

resource "azurerm_subnet_network_security_group_association" "web_subnet_nsg_associate" {
    depends_on = [ azurerm_network_security_rule.web_nsg_rule ]
    #it need to attache with your subnet
  subnet_id                 = azurerm_subnet.web_subnet.id
  #the nsg which we have created earlier
  network_security_group_id = azurerm_network_security_group.web_subnet_nsg.id
}
#inside nsg i want to open multiple rules
#every resource block in terraform can do single task
locals {
  web_inbound_port = { #web inbound port is the name
    "110" : "22",
    "120" : "80",
    "130" : "443"
  }
}
resource "azurerm_network_security_rule" "web_nsg_rule" {
  for_each = local.web_inbound_port
  name                        = "Rule-Port-${each.value}" #Rule-Port-22
  priority                    = each.key #110
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = each.value
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.rg.name
  network_security_group_name = azurerm_network_security_group.web_subnet_nsg.name
}
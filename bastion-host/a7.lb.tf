#we will create the public ip
resource "azurerm_public_ip" "lb_public_ip" {

  name = "${local.resource_name_prefix}-lb-publicip"

  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Static"
  sku                 = "Standard" #basic #premium
}
#azure lb
resource "azurerm_lb" "azurelb" {
  name = "${local.resource_name_prefix}-lb"

  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = "Standard" #premium #basic
  frontend_ip_configuration {
    name                 = "PublicIPAddress"
    public_ip_address_id = azurerm_public_ip.lb_public_ip.id
  }
}

#backend pool
resource "azurerm_lb_backend_address_pool" "azure_lb_backendpool" {
  loadbalancer_id = azurerm_lb.azurelb.id #will bne part of lb
  name            = "${local.resource_name_prefix}-lb-backendpool"
}
#lb probes
resource "azurerm_lb_probe" "lb_probe" {
  loadbalancer_id = azurerm_lb.azurelb.id
  name            = "${local.resource_name_prefix}-lb-probe"
  port            = 80
  protocol        = "Tcp"
  #request_path = "/var/app/index.php"
  interval_in_seconds = 15 #every 15 second it will ping your application
  number_of_probes    = 4  #if you application is not reachable in the 4 time 1 min
}
#lb rules
#how the load balancer is going to distrbute your traffic to vm
resource "azurerm_lb_rule" "lb_rule" {
  loadbalancer_id                = azurerm_lb.azurelb.id
  name                           = "${local.resource_name_prefix}-lb-rule"
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80 #tomcat 
  frontend_ip_configuration_name = azurerm_lb.azurelb.frontend_ip_configuration[0].name
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.azure_lb_backendpool.id]
  probe_id                       = azurerm_lb_probe.lb_probe.id
}

#assocate the nic card to backend pool
resource "azurerm_network_interface_backend_address_pool_association" "nic_association" {
  for_each                = var.car
  network_interface_id    = azurerm_network_interface.web_nic[each.key].id
  ip_configuration_name   = azurerm_network_interface.web_nic[each.key].ip_configuration[0].name
  backend_address_pool_id = azurerm_lb_backend_address_pool.azure_lb_backendpool.id
}
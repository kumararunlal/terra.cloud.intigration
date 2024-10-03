output "resource_group_name" {
  description = "this is the name of the resource group"
  #nameoftheresorce.refrence.name(this name come from tfstate file)
  value = azurerm_resource_group.rg.name
}
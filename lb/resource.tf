resource "azurerm_resource_group" "rg" {
  name = "${local.resource_name_prefix}-${var.resource_group_name}"
  #sap-dev-rg-key
  location = var.resource_group_location

  tags = local.project_tag
  #the block should be in locals
  ##when you call the value from the locals blocks local
}


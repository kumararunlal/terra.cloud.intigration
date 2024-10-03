variable "resource_group_name" {
  description = "this is the name of the resource group"
  type = string #list of string map it is like disctionary
  default = "rg-key"
}

variable "resource_group_location" {
  description = "this is the resource group location"
  type = string 
  default = "canadacentral"
}
#
variable "business_devision" {
  type = string 
  default = "sap"
}

variable "environment" {
  type = string 
  default = "dev"
}
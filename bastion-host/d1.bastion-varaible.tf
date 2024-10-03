variable "bastion_service_subnet" {
  type = string 
  default = "AzureBastionSubnet"
}

variable "bastion_service_subnet_prefix" {
  type = list(string)
  default = [ "10.0.101.0/27" ]
}
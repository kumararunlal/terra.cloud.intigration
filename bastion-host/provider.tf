##this is the provider block
terraform {
  required_providers {
    azurerm = { #aws
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }
}
#feature block
# Configure the Microsoft Azure Provider
provider "azurerm" {
  #resource_provider_registrations = "none" # This is only required when the User, Service Principal, or Identity running Terraform lacks the permissions to register Azure Resource Providers.
  #here we can define authentication or authorization global block
  #do_not_delete_storage
  features {}

}
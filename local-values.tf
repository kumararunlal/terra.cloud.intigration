locals {
  owners = var.business_devision #sap 
  environment = var.environment #dev
  ##if you want to concatinate varaibles you need to called them using $ symbol 
  resource_name_prefix = "${var.business_devision}-${var.environment}"
  #sap-dev
  #named expression 
  project_tag = { #this is the name
  #against that we define the expression 
  #but expression shoulw be in key value format
     owners = local.owners #sap
     environment  = local.environment #dev
  }
}
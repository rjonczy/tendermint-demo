# defines backend for terraform resources
terraform {
  backend "azurerm" {
    resource_group_name  = "pathrtfstates"
    storage_account_name = "pathrtf"
    container_name       = "tfstatedevops"
    key                  = "demo.tfstate"
  }
}

# defines provider
provider "azurerm" {
  features {}
}

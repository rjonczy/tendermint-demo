# defines backend for terraform resources
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.57.0"
    }
  }
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

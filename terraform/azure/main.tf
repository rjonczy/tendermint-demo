resource "azurerm_resource_group" "examplerg1" {
  name     = "tendermint-demo-1"
  location = "eastus2"
}

resource "azurerm_resource_group" "examplergi2" {
  name     = "tendermint-demo-2"
  location = "eastus2"
}

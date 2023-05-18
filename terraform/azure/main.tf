# Create Resource Group
resource "azurerm_resource_group" "examplerg" {
  name     = "tendermint-demo"
  location = "eastus2"
}

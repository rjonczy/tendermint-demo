resource "azurerm_resource_group" "tendermint" {
  name     = "${var.name}"
  location = "westeurope"
}



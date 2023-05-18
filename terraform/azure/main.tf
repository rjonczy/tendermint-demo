resource "azurerm_resource_group" "tendermint-rg" {
  name     = "tendermint-demo"
  location = "westeurope"
}


# module "cluster" {
#   source           = "./cluster"
#   name             = "${var.NETWORK_NAME}"
# }


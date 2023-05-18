variable "NETWORK_NAME" {
  description = "Name of the network"
  default     = "cosmos-demo"
}

# cluster of 4 vms for tendermint cluster
module "cluster" {
  source = "./cluster"
  name   = var.NETWORK_NAME
}



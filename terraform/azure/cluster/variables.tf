variable "rg_name" {
  description = "Name of the resource group"
}

variable "admin_ssh_key" {
  description = "Public key for admin account"
  type = string
}

variable "nodes" {
    description = "Nodes"
    type = map
    default = {
      "node_0" : { 
        name = "tendermint-node-0", 
        vm_size = "Standard_DS1_v2" 
      },
      "node_1" : { 
        name = "tendermint-node-1", 
        vm_size = "Standard_DS1_v2"
      },
      "node_2" : { 
        name = "tendermint-node-2", 
        vm_size = "Standard_DS1_v2" 
      },
      "node_3" : { 
        name = "tendermint-node-3", 
        vm_size = "Standard_DS1_v2" 
      }
    }
}
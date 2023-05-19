variable "NETWORK_NAME" {
  description = "Name of the network"
  default     = "tendermint-demo"
}

locals {
  cluster_nodes = {
    "node_0" : { name = "tendermint-node-0", vm_size = "Standard_DS1_v2" },
    "node_1" : { name = "tendermint-node-1", vm_size = "Standard_DS1_v2" },
    "node_2" : { name = "tendermint-node-2", vm_size = "Standard_DS1_v2" },
    "node_3" : { name = "tendermint-node-3", vm_size = "Standard_DS1_v2" }
  }
  # TODO: priv of this add to SECRETS for Gtihub Actions
  ssh_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDTfBrbqNQtrenIcSNxTT9MhlLVLGCTkM74KrIZ8KV/H5cFbeU//7300iJCms3Oqda2Bt4hfFZz7DnbEDJ8LxnYhgYJMY9HeoLF8QCDZWonwApibT2jKa19Pj1g7bsa+gFhMVZpxkSjNzf+ri4ze5TGm2u3jgs5ZO3vVRaCmObos5Vh2VMNCosoiwHUcz80X3UI6eJnA+uAs5iPLSrmdeqbYeSCSDW9auIqqeaygXXkFFKcypMaqSBGGsLWhCmoTnOy+AjQhd0jvdWxKt27c3q3q6QbUybm8/TytN6xMgHWvCBjTEGvj0hkTm9KiPRUveTczsKFDwrZZuK7/SK64GIU2I+O2jOsiZbJkCDNx4QK+vSp4oE8rcYSQS3gnSnZ1y/X7egeXytxflMzV9GWyvc8MtoRrEH0kp49Qt5yeoB75zwxSP83yAIJGPb4Y2cMqneZhmqLrnP80yVkELgG1/0mezfNHhK4Xgvkomx843eku5iYT3wi7EFM3loiiEjOED8= rjonczy@napierdalator"
}

# cluster of 4 vms for tendermint cluster
module "cluster" {
  source        = "./cluster"
  rg_name       = var.NETWORK_NAME
  nodes         = local.cluster_nodes
  admin_ssh_key = local.ssh_key
}




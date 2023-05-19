// The cluster name
output "rg_name" {
  value = "${var.rg_name}"
}

output "private_ips" {
  value = [azurerm_network_interface.nic.*]
}
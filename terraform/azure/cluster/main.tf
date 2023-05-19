resource "azurerm_resource_group" "rg" {
  name     = "${var.rg_name}"
  location = "westeurope"
}

resource "azurerm_virtual_network" "network" {
  name                = "tendermint-demo"
  address_space       = ["192.168.0.0/16"]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_subnet" "subnet" {
  name                 = "tendermint"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.network.name
  address_prefixes     = ["192.168.10.0/24"]
}

resource "azurerm_network_security_group" "nsg" {
  name                = "tendermint-sg"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  security_rule {
    name                       = "SSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_public_ip" "public_ip" {
  for_each            = var.nodes
  name                ="public_ip-${each.value.name}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Dynamic"
}

resource "azurerm_network_interface" "nic" {

  for_each            = var.nodes
  name                = "nic-${each.value.name}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "nic_conf"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.public_ip[each.key].id
  }
}

resource "azurerm_network_interface_security_group_association" "nic_nsg" {
  for_each                  = var.nodes
  network_interface_id      = azurerm_network_interface.nic[each.key].id
  network_security_group_id = azurerm_network_security_group.nsg.id
}

resource "random_id" "random_id" {
  keepers = {
    # Generate a new ID only when a new resource group is defined
    resource_group = azurerm_resource_group.rg.name
  }

  byte_length = 8
}

# resource "azurerm_storage_account" "diag_storage_account" {
#   name                     = "diagtendermintdemo"
#   location                 = azurerm_resource_group.rg.location
#   resource_group_name      = azurerm_resource_group.rg.name
#   account_tier             = "Standard"
#   account_replication_type = "LRS"
# }

resource "azurerm_linux_virtual_machine" "tendermint-node" {
  for_each              = var.nodes
  name                  = each.value.name
  location              = azurerm_resource_group.rg.location
  resource_group_name   = azurerm_resource_group.rg.name
  network_interface_ids = [azurerm_network_interface.nic[each.key].id]
  size                  = each.value.vm_size

  os_disk {
    name                 = "${each.value.name}-osdisk"
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }

  computer_name                   = each.value.name
  admin_username                  = "rjonczy"
  disable_password_authentication = true

  admin_ssh_key {
    username   = "rjonczy"
    public_key = var.admin_ssh_key
  }

  # boot_diagnostics {
  #   storage_account_uri = azurerm_storage_account.diag_storage_account.primary_blob_endpoint
  # }
}

resource "azurerm_dns_zone" "cosmos-zone" {
  name                = "demo.jonczy.dev"
  resource_group_name = azurerm_resource_group.rg.name
}
resource "azurerm_virtual_network" "primary" {
  name                = var.virtual_network_primary_name
  address_space       = var.virtual_network_primary_address_space
  location            = var.location
  resource_group_name = var.resource_group_name
}

resource "azurerm_network_interface" "primary_nic" {
  name                = var.network_interface_primary_nic_name
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet-2.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.primary.id
  }
}

resource "azurerm_network_interface_security_group_association" "primary" {
  network_interface_id      = azurerm_network_interface.primary_nic.id
  network_security_group_id = azurerm_network_security_group.primary_nsg.id
}

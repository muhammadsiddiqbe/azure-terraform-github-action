resource "azurerm_public_ip" "primary" {
  name                = var.public_ip_primary_name
  resource_group_name = var.resource_group_name
  location            = var.resource_group_location
  allocation_method   = var.public_ip_primary_allocation_method

  tags = {
    environment = var.environment
  }
}
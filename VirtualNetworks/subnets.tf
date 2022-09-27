resource "azurerm_subnet" "subnet" {
  name                 = var.subnet_primary_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.virtual_network_primary_name
  address_prefixes     = var.subnet_primary_address_prefixes

  enforce_private_link_endpoint_network_policies = true

  depends_on = [
    azurerm_virtual_network.primary
  ]

}
resource "azurerm_public_ip" "primary" {
  name                = var.public_ip_primary_name
  resource_group_name = var.resource_group_name
  location            = var.resource_group_name
  allocation_method   = var.public_ip_primary_allocation_method

  tags = {
    environment = var.environment
  }
}

resource "azurerm_virtual_network" "primary" {
  name                = var.virtual_network_primary_name
  address_space       = var.virtual_network_primary_address_space
  location            = var.location
  resource_group_name = var.resource_group_name
}

resource "azurerm_subnet" "subnet" {
  name                 = var.subnet_primary_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.primary.name
  address_prefixes     = var.subnet_primary_address_prefixes

  enforce_private_link_endpoint_network_policies = true

}

# resource "azurerm_private_endpoint" "psql-funcapp" {
#   name                = "psql-funcapp-endpoint"
#   location            = var.location
#   resource_group_name = var.resource_group_name
#   subnet_id           = azurerm_subnet.subnet.id

#   private_service_connection {
#     name                           = "psql-funcapp-privateserviceconnection"
#     private_connection_resource_id = azurerm_postgresql_server.main-psql.id
#     subresource_names              = ["postgresqlServer"]
#     is_manual_connection           = false
#   }
# }

resource "azurerm_network_interface" "primary_nic" {
  name                = var.network_interface_primary_nic_name
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.primary.id
  }
}

resource "azurerm_network_security_group" "my_terraform_nsg" {
  name                = var.my_terraform_nsg
  location            = var.location
  resource_group_name = var.resource_group_name

  security_rule {
    name                       = "SSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  depends_on = [
    azurerm_network_interface.primary_nic
  ]
}

resource "azurerm_network_interface_security_group_association" "primary_nisga" {
  network_interface_id      = azurerm_network_interface.primary_nic.id
  network_security_group_id = azurerm_network_security_group.my_terraform_nsg.id
}

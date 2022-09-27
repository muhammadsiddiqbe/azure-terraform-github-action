resource "azurerm_private_endpoint" "psql-funcapp" {
  name                = "psql-funcapp-endpoint"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  subnet_id           = azurerm_subnet.subnet.id

  private_service_connection {
    name                           = "psql-funcapp-privateserviceconnection"
    private_connection_resource_id = var.psql_db_resource_id
    subresource_names              = ["postgresqlServer"]
    is_manual_connection           = false
  }
}

resource "azurerm_private_endpoint" "servicebus-endpoint" {
  name                = "psql-funcapp-endpoint"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  subnet_id           = azurerm_subnet.subnet.id

  private_service_connection {
    name                           = "servicebus-privateserviceconnection"
    private_connection_resource_id = var.azurerm_servicebus_namespace_primary_id
    subresource_names              = ["namespace"]
    is_manual_connection           = false
  }
}
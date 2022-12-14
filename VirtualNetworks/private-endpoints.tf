resource "azurerm_private_endpoint" "psql-funcapp" {
  name                = "psql-funcapp-endpoint"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  subnet_id           = azurerm_subnet.subnet-2.id

  private_service_connection {
    name                           = "psql-funcapp-privateserviceconnection"
    private_connection_resource_id = var.psql_db_resource_id
    subresource_names              = ["postgresqlServer"]
    is_manual_connection           = false
  }
}

# resource "azurerm_private_endpoint" "servicebus-endpoint" {
#   name                = "psql-funcapp-endpoint"
#   location            = var.resource_group_location
#   resource_group_name = var.resource_group_name
#   subnet_id           = azurerm_subnet.subnet-3.id

#   private_service_connection {
#     name                           = "servicebus-privateserviceconnection"
#     private_connection_resource_id = var.azurerm_servicebus_namespace_primary_id
#     subresource_names              = ["namespace"]
#     is_manual_connection           = false
#   }
# } # requiring premium version :(

resource "azurerm_private_endpoint" "stg-acc-private-endpoint" {
  name                = "stg-acc-private-endpoint"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  subnet_id           = azurerm_subnet.subnet-3.id

  private_service_connection {
    name                           = "storage-account-privateserviceconnection"
    private_connection_resource_id = var.stg_acc_rc_id
    subresource_names              = ["blob"]
    is_manual_connection           = false
  }
}
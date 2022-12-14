output "namespace_connection_string" {
  value = azurerm_servicebus_namespace.primary.default_primary_connection_string
}

output "shared_access_policy_primarykey" {
  value = azurerm_servicebus_namespace.primary.default_primary_key
}

output "azurerm_servicebus_namespace_primary_id" {
  value = azurerm_servicebus_namespace.primary.id
}
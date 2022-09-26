resource "azurerm_eventgrid_event_subscription" "example" {
  name  = "${var.prefix}-eventsubs"
  scope = azurerm_resource_group.example.id

  storage_queue_endpoint {
    storage_account_id = azurerm_storage_account.example.id
    queue_name         = azurerm_storage_queue.example.name
  }

  storage_blob_dead_letter_destination {
    storage_account_id          = azurerm_storage_account.example.id
    storage_blob_container_name = azurerm_storage_container.example.name
  }

  retry_policy {
    event_time_to_live    = 11
    max_delivery_attempts = 11
  }

  labels = ["test", "test1", "test2"]
}
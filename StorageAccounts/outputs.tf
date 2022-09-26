output "stg_acc_name_out" {
  value = azurerm_storage_account.primary.name
}

output "stg_acc_access_key_out" {
  value = azurerm_storage_account.primary.primary_access_key
}

output "stg_acc_id_out" {
  value = azurerm_storage_account.primary.id
}

output "stg_acc_queue_name_out" {
  value = azurerm_storage_queue.primary.name
}

output "storage_blob_container_name_out" {
  value = azurerm_storage_container.primary.name
}
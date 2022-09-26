output "stg_acc_name" {
  value = azurerm_storage_account.primary.name
}

output "stg_acc_access_key" {
  value = azurerm_storage_account.primary.primary_access_key
}
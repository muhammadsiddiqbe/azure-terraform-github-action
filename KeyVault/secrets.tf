resource "azurerm_key_vault_secret" "example" {
  name         = "example"
  value        = "example-value"
  key_vault_id = azurerm_key_vault.primary.id
}
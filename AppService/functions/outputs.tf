output "function_id" {
  value = azurerm_linux_function_app.fxn.id
}

output "eventGridFunctionName" {
  value = azurerm_linux_function_app.fxn.name
}
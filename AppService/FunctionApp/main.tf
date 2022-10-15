provider "azurerm" {
  features {}
}

resource "azurerm_service_plan" "primary" {
  name                = "${var.prefix}-sp-4565"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  os_type             = "Linux"
  sku_name            = "S1"
}

resource "azurerm_linux_function_app" "primary" {
  name                = "main-func-app-4565"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name

  service_plan_id = azurerm_service_plan.primary.id
  storage_account_name       = var.storage_account_name
  storage_account_access_key = var.storage_account_access_key

  site_config {}

  app_settings = {
    "WEBSITE_USE_ZIP"       = "https://tfstatestgacc4565.blob.core.windows.net/mycode/az-funcs.zip",
    "FUNCTIONS_WORKER_RUNTIME"       = "node",
    "APPINSIGHTS_INSTRUMENTATIONKEY" = azurerm_application_insights.logging.instrumentation_key,
  }

  connection_string {
    name = "PostgreSQL"
    type = "PostgreSQL"
    value = "somevalue"

  }
}

resource "azurerm_linux_function_app" "function_app" {
  name                = "secondary-func-app-234"
  resource_group_name = var.resource_group_name
  location            = var.resource_group_location

  service_plan_id = azurerm_service_plan.primary.id
  storage_account_name       = var.storage_account_name
  storage_account_access_key = var.storage_account_access_key


  app_settings = {
    # "WEBSITE_RUN_FROM_PACKAGE"       = "https://tfstatestgacc4565.blob.core.windows.net/mycode/az-funcs.zip",
    "FUNCTIONS_WORKER_RUNTIME"       = "node",
    "APPINSIGHTS_INSTRUMENTATIONKEY" = azurerm_application_insights.logging.instrumentation_key,
  }

  site_config {

  }

  lifecycle {

  }

  connection_string {
    name = "ServiceBus"
    type = "ServiceBus"
    value = "somevalue"

  }

}

resource "azurerm_application_insights" "logging" {
  name                = "${var.prefix}-ai283"
  location            = var.location
  resource_group_name = var.resource_group_name
  application_type    = "web"
  retention_in_days   = 90
  tags = {
    sample = "azure-functions-event-grid-terraform"
  }
}
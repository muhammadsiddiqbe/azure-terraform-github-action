resource "azurerm_application_insights" "application_insights" {
  name                = "${var.prefix}-${var.environment}-application-insights"
  location            = var.location
  resource_group_name = var.resource_group_name
  application_type    = "Node.JS"
}
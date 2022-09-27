resource "azurerm_eventgrid_event_subscription" "primary" {
  name  = "${var.prefix}-eventsubs"
  scope = var.resource_group_id

  storage_queue_endpoint {
    storage_account_id = var.storage_account_id
    queue_name         = var.queue_name
  }

  storage_blob_dead_letter_destination {
    storage_account_id          = var.storage_account_id
    storage_blob_container_name = var.storage_blob_container_name
  }

  retry_policy {
    event_time_to_live    = 11
    max_delivery_attempts = 11
  }

  labels = ["test", "test1", "test2"]
}

resource "azurerm_eventgrid_topic" "sample_topic" {
  name                = "${var.prefix}-azsam-egt"
  location            = var.location
  resource_group_name = var.resource_group_name
  tags = {
    sample = "azure-functions-event-grid-terraform"
  }
}

# resource "azurerm_application_insights" "logging" {
#   name                = "${var.prefix}-ai"
#   location            = var.location
#   resource_group_name = azurerm_resource_group.sample.name
#   application_type    = "web"
#   retention_in_days   = 90
#   tags = {
#     sample = "azure-functions-event-grid-terraform"
#   }
# }


# module "Functions" {
#   source = "../AppService/FunctionApp"

# }
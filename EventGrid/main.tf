resource "azurerm_resource_group" "sample" {
  name     = "${var.prefix}-sample-rg"
  location = var.location
  tags = {
    sample = "azure-functions-event-grid-terraform"
  }
}

resource "azurerm_eventgrid_topic" "sample_topic" {
  name                = "${var.prefix}-azsam-egt"
  location            = var.location
  resource_group_name = var.resource_group_name
  tags = {
    sample = "azure-functions-event-grid-terraform"
  }
}

resource "azurerm_application_insights" "logging" {
  name                = "${var.prefix}-ai"
  location            = var.location
  resource_group_name = var.resource_group_name
  application_type    = "web"
  retention_in_days   = 90
  tags = {
    sample = "azure-functions-event-grid-terraform"
  }
}

resource "azurerm_storage_account" "inbox" {
  name                      = "${var.prefix}inboxsa"
  resource_group_name       = var.resource_group_name
  location                  = var.location
  account_tier              = "Standard"
  account_replication_type  = "LRS"
  account_kind              = "StorageV2"
  enable_https_traffic_only = true
  tags = {
    sample = "azure-functions-event-grid-terraform"
  }
}

module "functions" {
  source                                   = "../AppService/functions"
  prefix                                   = var.prefix
  resource_group_name                      = azurerm_resource_group.sample.name
  location                                 = azurerm_resource_group.sample.location
  application_insights_instrumentation_key = azurerm_application_insights.logging.instrumentation_key
  sample_topic_endpoint                    = azurerm_eventgrid_topic.sample_topic.endpoint
  sample_topic_key                         = azurerm_eventgrid_topic.sample_topic.primary_access_key
}

resource "azurerm_eventgrid_event_subscription" "eventgrid_subscription" {
  name   = "${var.prefix}-handlerfxn-egsub"
  scope  = azurerm_storage_account.inbox.id
  labels = ["azure-functions-event-grid-terraform"]

  azure_function_endpoint {
    function_id = "${module.functions.function_id}/functions/${module.functions.eventGridFunctionName}"

    # defaults, specified to avoid "no-op" changes when 'apply' is re-ran
    max_events_per_batch              = 1
    preferred_batch_size_in_kilobytes = 64
  }
}


# resource "azurerm_eventgrid_event_subscription" "primary" {
#   name  = "${var.prefix}-eventsubs"
#   scope = var.resource_group_id

#   storage_queue_endpoint {
#     storage_account_id = var.storage_account_id
#     queue_name         = var.queue_name
#   }

#   storage_blob_dead_letter_destination {
#     storage_account_id          = var.storage_account_id
#     storage_blob_container_name = var.storage_blob_container_name
#   }

#   retry_policy {
#     event_time_to_live    = 11
#     max_delivery_attempts = 11
#   }
# }

# resource "azurerm_eventgrid_topic" "sample_topic" {
#   name                = "${var.prefix}-azsam-egt"
#   location            = var.location
#   resource_group_name = var.resource_group_name
#   tags = {
#     sample = "azure-functions-event-grid-terraform"
#   }
# }

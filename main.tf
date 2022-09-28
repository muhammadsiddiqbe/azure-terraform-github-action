# Configure the Azure provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0.2"
    }
  }

  required_version = ">= 1.1.0"
}

provider "azurerm" {
  features {
    key_vault {
      purge_soft_delete_on_destroy = true
    }
  }
}

data "azuread_client_config" "current" {}

# Modules

module "ResourceGroups" {
  source = "./ResourceGroups"

  location    = var.location
  environment = var.environment
}

module "VirtualNetworks" {
  source      = "./VirtualNetworks"
  location    = var.location
  environment = var.environment

  public_ip_primary_name             = "${var.prefix}_primary_ip"
  virtual_network_primary_name       = "${var.prefix}_primary_vn"
  subnet_primary_name                = "${var.prefix}_primary_subnet"
  resource_group_name                = module.ResourceGroups.rg_name_out
  resource_group_location            = module.ResourceGroups.rg_location_out
  network_interface_primary_nic_name = "${var.prefix}_primary_nic"
  my_terraform_nsg                   = "${var.prefix}_primary_nsg"
  psql_db_resource_id                = module.PostgreSQL.psql_db_resource_id_out

  azurerm_servicebus_namespace_primary_id = module.ServiceBus.azurerm_servicebus_namespace_primary_id

  stg_acc_rc_id = module.StorageAccount.stg_acc_id_out

  depends_on = [
    module.StorageAccount
  ]
}

module "StorageAccount" {
  source = "./StorageAccounts"

  base_name = "${var.prefix}storage"
  location  = var.location

  resource_group_name = module.ResourceGroups.rg_name_out
}

module "PostgreSQL" {
  source              = "./PostgreSQL"
  base_name           = "${var.prefix}psql"
  location            = var.location
  resource_group_name = module.ResourceGroups.rg_name_out

  psql_admin_login    = var.psql_admin_login
  psql_admin_password = var.psql_admin_password
}

module "VirtualMachines" {
  source = "./VirtualMachines"

  resource_group_name = module.ResourceGroups.rg_name_out
  location            = var.location
  prefix              = var.prefix
  vm_nic_id           = module.VirtualNetworks.vn_nic_id
}

module "ServiceBus" {
  source = "./ServiceBus"

  prefix                  = var.prefix
  location                = var.location
  resource_group_name     = module.ResourceGroups.rg_name_out
  resource_group_location = module.ResourceGroups.rg_location_out
}

module "AppService" {
  source = "./AppService/FunctionApp"

  prefix      = var.prefix
  location    = var.location
  environment = var.environment

  resource_group_name             = module.ResourceGroups.rg_name_out
  resource_group_location         = module.ResourceGroups.rg_location_out
  linux_function_app_primary_name = "primary-func-app"
  storage_account_namse            = module.StorageAccount.stg_acc_name_out
  storage_account_access_key      = module.StorageAccount.stg_acc_access_key_out

  # depends_on = [
  #   module.StorageAccount
  # ]
}

module "EventGrid" {
  source   = "./EventGrid"
  prefix   = var.prefix
  location = var.location

  resource_group_id           = module.ResourceGroups.resource_group_id_out
  resource_group_name         = module.ResourceGroups.rg_name_out
  queue_name                  = module.StorageAccount.stg_acc_queue_name_out
  storage_account_id          = module.StorageAccount.stg_acc_id_out
  storage_blob_container_name = module.StorageAccount.storage_blob_container_name_out

  depends_on = [
    module.StorageAccount
  ]
}
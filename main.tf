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

output "object_id" {
  value = data.azuread_client_config.current.object_id
}

# Modules

module "ResourceGroups" {
  source = "./ResourceGroups"

  resource_group_name = "MainRG"
  resource_group_location = "eastus"
  environment = var.environment
}

module "VirtualNetworks" {
  source = "./VirtualNetworks"

  public_ip_primary_name = "${var.project}_primary_ip"
  environment = var.environment
  virtual_network_primary_name = "${var.project}_primary_vn"
  location = var.location
  subnet_primary_name = "${var.project}_primary_subnet"
  resource_group_name = module.ResourceGroups.rg_name_out
  resource_group_location = module.ResourceGroups.rg_location_out
  network_interface_primary_nic_name = "${var.project}_primary_nic"
  my_terraform_nsg = "${var.project}_primary_nsg"

}

module "StorageAccount" {
  source = "./StorageAccounts"
  base_name = "mypro"
  resource_group_name = module.ResourceGroups.rg_name_out
  location = var.location
}
variable "prefix" {
  default     = "awsiy"
  type        = string
  description = "Project name"
}

variable "environment" {
  default     = "dev"
  type        = string
  description = "Environment (dev / stage / prod)"
}

variable "location" {
  default     = "eastus"
  type        = string
  description = "Azure region to deploy module to"
}

# POSTGRESQL

variable "psql_admin_login" {
  type      = string
  sensitive = true
  default   = "awsiyadmin"
}

variable "psql_admin_password" {
  type      = string
  sensitive = true
  default   = "oit1slAac^OcHir1:)@"
}

# KUBERNETES

variable "agent_count" {
  default = 3
}

# The following two variable declarations are placeholder references.
# Set the values for these variable in terraform.tfvars
variable "aks_service_principal_app_id" {
  default = ""
}

variable "aks_service_principal_client_secret" {
  default = ""
}

variable "cluster_name" {
  default = "k8stest"
}

variable "dns_prefix" {
  default = "k8stest"
}

# Refer to https://azure.microsoft.com/global-infrastructure/services/?products=monitor for available Log Analytics regions.
variable "log_analytics_workspace_location" {
  default = "eastus"
}

variable "log_analytics_workspace_name" {
  default = "testLogAnalyticsWorkspaceName"
}

# Refer to https://azure.microsoft.com/pricing/details/monitor/ for Log Analytics pricing
variable "log_analytics_workspace_sku" {
  default = "PerGB2018"
}

variable "resource_group_location" {
  default     = "eastus"
  description = "Location of the resource group."
}

variable "resource_group_name_prefix" {
  default     = "rg"
  description = "Prefix of the resource group name that's combined with a random ID so name is unique in your Azure subscription."
}

variable "ssh_public_key" {
  default = "~/.ssh/id_rsa.pub"
}
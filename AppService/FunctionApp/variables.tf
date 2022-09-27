variable "prefix" {
  type        = string
  description = "The prefix used for all resources in this example"
}

variable "location" {
  type        = string
  description = "The Azure location where all resources in this example should be created"
}

variable "environment" {
  type = string
  description = "Application environment"
}

variable "resource_group_name" {
  type        = string
  description = "resource group"
}

variable "resource_group_location" {
  type        = string
}

variable "linux_function_app_primary_name" {
  type        = string
}

variable "storage_account_name" {
  type        = string
}
variable "storage_account_access_key" {
  type        = string
}
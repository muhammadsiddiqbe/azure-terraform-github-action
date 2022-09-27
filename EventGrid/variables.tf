variable "prefix" {
  description = "The Prefix used for all resources in this example"
}

variable "location" {
  description = "The Azure Region in which all resources in this example should be created."
}

variable "resource_group_id" {
  type = string
}

variable "resource_group_name"{
  type = string
  default = ""
}

variable "queue_name" {
  type = string
}

variable "storage_account_id" {
  type = string
}

variable "storage_blob_container_name" {
  type = string
}
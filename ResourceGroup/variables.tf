variable "resource_group_name" {
  type        = string
  default     = "myTFResourceGroup"
  description = "main resource group"
}

variable "resource_group_location" {
  type = string
  default = "RG"
}

variable "environment" {
  type = string
  default = "dev"
}
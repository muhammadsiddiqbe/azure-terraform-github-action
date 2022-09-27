variable "prefix" {
  description = "The prefix which should be used for all resources in this example"
}

variable "resource_group_name"{
  type = string
  default = ""
}

variable "location" {
  description = "The Azure Region in which all resources in this example should be created."
}

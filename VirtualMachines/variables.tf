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

variable "primary_linux_vm_name" {
  type    = string
  default = "main-vm"
}

variable "primary_linux_vm_size" {
  type    = string
  default = "Standard_F2"
}

variable "primary_linux_vm_adminuser" {
  type    = string
  default = "adminuser"
}

variable "vm_nic_id" {
  type = string
  description = "vm network interface id should be list"
}
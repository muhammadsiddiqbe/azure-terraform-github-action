variable "public_ip_primary_name" {
  type    = string
  default = "acceptanceTestPublicIp1"
}

variable "public_ip_primary_allocation_method" {
  type    = string
  default = "Static"
}

variable "virtual_network_primary_name" {
  type    = string
  default = "myTFVnet"
}

variable "virtual_network_primary_address_space" {
  type    = list(any)
  default = ["10.0.0.0/16"]
}

variable "subnet_primary_name" {
  type    = string
  default = "internal"
}

variable "subnet_primary_address_prefixes" {
  type    = list(any)
  default = ["10.0.2.0/24"]
}

variable "network_interface_primary_nic_name" {
  type    = string
  default = "primary-nic"
}

variable "my_terraform_nsg" {
  type    = string
  default = "myNetworkSecurityGroup"
}

variable "resource_group_name" {
  type = string
  default = ""
}

variable "location" {
  type = string
  default = "eastus"
}

variable "environment" {
  type = string
  default = "prod"
}

variable "resource_group_location" {
  type = string
  default = ""
}

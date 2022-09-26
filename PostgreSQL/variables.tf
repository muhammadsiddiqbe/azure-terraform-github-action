variable "base_name" {
  type = string
  default = ""
}

variable "location" {
  type = string
  default = ""
}

variable "resource_group_name" {
  type = string
  default = ""
}

variable "psql_admin_login" {
  type = string
  sensitive = true
}

variable "psql_admin_password" {
  type = string
  sensitive = true
}
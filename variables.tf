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
  default = "awsiyadmin"
}

variable "psql_admin_password" {
  type      = string
  sensitive = true
  default = "oit1slAac^OcHir1:)@"
}
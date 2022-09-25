variable "project" {
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
# Variables for Azure Databricks Module

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Azure region for resources"
  type        = string
}

variable "workspace_name" {
  description = "Name of the Databricks workspace"
  type        = string
}

variable "sku" {
  description = "SKU for Databricks workspace"
  type        = string
  default     = "premium"
}

variable "customer_managed_key_enabled" {
  description = "Enable customer-managed key"
  type        = bool
  default     = false
}

variable "key_vault_id" {
  description = "ID of the Key Vault for customer-managed key"
  type        = string
  default     = null
}

variable "key_vault_key_name" {
  description = "Name of the Key Vault key"
  type        = string
  default     = null
}

variable "key_vault_key_version" {
  description = "Version of the Key Vault key"
  type        = string
  default     = null
}

variable "vnet_peering_enabled" {
  description = "Enable VNet peering"
  type        = bool
  default     = false
}

variable "vnet_id" {
  description = "ID of the VNet to peer with"
  type        = string
  default     = null
}

variable "databricks_vnet_id" {
  description = "ID of the Databricks VNet"
  type        = string
  default     = null
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}

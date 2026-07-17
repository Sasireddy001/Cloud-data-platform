# Variables for Terraform configuration

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
  default     = "cloud-data-platform-rg"
}

variable "location" {
  description = "Azure region for resources"
  type        = string
  default     = "eastus"
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default = {
    Project     = "Cloud Data Platform"
    ManagedBy   = "Terraform"
    Environment = "dev"
  }
}

# Storage variables
variable "storage_account_name" {
  description = "Name of the storage account"
  type        = string
  default     = "clouddataplatstg"
}

variable "account_replication_type" {
  description = "Replication type for storage account"
  type        = string
  default     = "LRS"
}

variable "delta_container_name" {
  description = "Name of the Delta container"
  type        = string
  default     = "delta"
}

variable "checkpoint_container_name" {
  description = "Name of the checkpoint container"
  type        = string
  default     = "checkpoints"
}

variable "capture_container_name" {
  description = "Name of the Event Hub capture container"
  type        = string
  default     = "capture"
}

variable "delta_filesystem_name" {
  description = "Name of the Delta filesystem"
  type        = string
  default     = "delta"
}

# Event Hub variables
variable "event_hub_namespace_name" {
  description = "Name of the Event Hubs namespace"
  type        = string
  default     = "cloud-event-hubs-ns"
}

variable "event_hub_name" {
  description = "Name of the Event Hub"
  type        = string
  default     = "events"
}

variable "partition_count" {
  description = "Number of partitions for the Event Hub"
  type        = number
  default     = 2
}

variable "message_retention" {
  description = "Message retention period in days"
  type        = number
  default     = 7
}

variable "consumer_group_name" {
  description = "Name of the consumer group"
  type        = string
  default     = "$Default"
}

variable "authorization_rule_name" {
  description = "Name of the authorization rule"
  type        = string
  default     = "RootManageSharedAccessKey"
}

variable "event_hub_sku" {
  description = "SKU for Event Hubs namespace"
  type        = string
  default     = "Standard"
}

variable "event_hub_capacity" {
  description = "Capacity for Event Hubs namespace"
  type        = number
  default     = 1
}

# Databricks variables
variable "databricks_workspace_name" {
  description = "Name of the Databricks workspace"
  type        = string
  default     = "cloud-databricks-ws"
}

variable "databricks_sku" {
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

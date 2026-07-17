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

variable "databricks_workspace_name" {
  description = "Name of the Databricks workspace"
  type        = string
  default     = "cloud-databricks-ws"
}

variable "storage_account_name" {
  description = "Name of the storage account"
  type        = string
  default     = "clouddataplatstg"
}

variable "environment" {
  description = "Environment name (dev, prod)"
  type        = string
  default     = "dev"
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

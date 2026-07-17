# Variables for Azure Event Hub Module

variable "namespace_name" {
  description = "Name of the Event Hubs namespace"
  type        = string
}

variable "location" {
  description = "Azure region for resources"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "sku" {
  description = "SKU for Event Hubs namespace"
  type        = string
  default     = "Standard"
}

variable "capacity" {
  description = "Capacity for Event Hubs namespace"
  type        = number
  default     = 1
}

variable "event_hub_name" {
  description = "Name of the Event Hub"
  type        = string
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

variable "storage_account_id" {
  description = "ID of the storage account for Event Hub capture"
  type        = string
}

variable "storage_container_name" {
  description = "Name of the storage container for Event Hub capture"
  type        = string
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}

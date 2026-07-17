# Variables for Azure Storage Module

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Azure region for resources"
  type        = string
}

variable "storage_account_name" {
  description = "Name of the storage account"
  type        = string
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

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}

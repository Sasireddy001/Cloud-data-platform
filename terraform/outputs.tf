# Outputs from Terraform configuration

output "resource_group_name" {
  description = "Name of the resource group"
  value       = azurerm_resource_group.rg.name
}

output "event_hub_namespace_name" {
  description = "Name of the Event Hubs namespace"
  value       = module.event_hub.namespace_name
}

output "event_hub_name" {
  description = "Name of the Event Hub"
  value       = module.event_hub.event_hub_name
}

output "event_hub_connection_string" {
  description = "Connection string for Event Hubs (sensitive)"
  value       = module.event_hub.connection_string
  sensitive   = true
}

output "databricks_workspace_name" {
  description = "Name of the Databricks workspace"
  value       = module.databricks.workspace_name
}

output "databricks_workspace_url" {
  description = "URL of the Databricks workspace"
  value       = module.databricks.workspace_url
}

output "storage_account_name" {
  description = "Name of the storage account"
  value       = module.storage.storage_account_name
}

output "storage_account_primary_key" {
  description = "Primary key of the storage account (sensitive)"
  value       = module.storage.primary_key
  sensitive   = true
}

output "delta_path" {
  description = "Path to Delta Lake storage"
  value       = module.storage.delta_path
}

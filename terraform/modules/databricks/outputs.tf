# Outputs for Azure Databricks Module

output "workspace_name" {
  description = "Name of the Databricks workspace"
  value       = azurerm_databricks_workspace.this.name
}

output "workspace_id" {
  description = "ID of the Databricks workspace"
  value       = azurerm_databricks_workspace.this.id
}

output "workspace_url" {
  description = "URL of the Databricks workspace"
  value       = azurerm_databricks_workspace.this.workspace_url
}

output "databricks_host" {
  description = "Host URL for Databricks API"
  value       = "https://${azurerm_databricks_workspace.this.workspace_url}"
}

output "resource_group_name" {
  description = "Name of the resource group"
  value       = var.resource_group_name
}

output "location" {
  description = "Azure region"
  value       = var.location
}

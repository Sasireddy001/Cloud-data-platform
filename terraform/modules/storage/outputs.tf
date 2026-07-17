# Outputs for Azure Storage Module

output "resource_group_name" {
  description = "Name of the resource group"
  value       = azurerm_resource_group.this.name
}

output "resource_group_id" {
  description = "ID of the resource group"
  value       = azurerm_resource_group.this.id
}

output "storage_account_name" {
  description = "Name of the storage account"
  value       = azurerm_storage_account.this.name
}

output "storage_account_id" {
  description = "ID of the storage account"
  value       = azurerm_storage_account.this.id
}

output "primary_key" {
  description = "Primary access key (sensitive)"
  value       = azurerm_storage_account.this.primary_access_key
  sensitive   = true
}

output "delta_path" {
  description = "Path to Delta Lake storage"
  value       = "abfss://${var.delta_filesystem_name}@${azurerm_storage_account.this.name}.dfs.core.windows.net/delta"
}

output "checkpoint_path" {
  description = "Path to checkpoint storage"
  value       = "abfss://${var.delta_filesystem_name}@${azurerm_storage_account.this.name}.dfs.core.windows.net/checkpoints"
}

output "delta_filesystem_name" {
  description = "Name of the Delta filesystem"
  value       = var.delta_filesystem_name
}

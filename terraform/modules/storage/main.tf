# Azure Storage Module

resource "azurerm_resource_group" "this" {
  name     = var.resource_group_name
  location = var.location

  tags = var.tags
}

resource "azurerm_storage_account" "this" {
  name                     = var.storage_account_name
  resource_group_name      = azurerm_resource_group.this.name
  location                 = azurerm_resource_group.this.location
  account_tier             = "Standard"
  account_replication_type = var.account_replication_type
  is_hns_enabled           = true

  tags = var.tags
}

resource "azurerm_storage_container" "delta" {
  name                  = var.delta_container_name
  storage_account_name   = azurerm_storage_account.this.name
  container_access_type = "private"
}

resource "azurerm_storage_container" "checkpoints" {
  name                  = var.checkpoint_container_name
  storage_account_name   = azurerm_storage_account.this.name
  container_access_type = "private"
}

resource "azurerm_storage_container" "capture" {
  name                  = var.capture_container_name
  storage_account_name   = azurerm_storage_account.this.name
  container_access_type = "private"
}

resource "azurerm_storage_data_lake_gen2_filesystem" "delta" {
  name                = var.delta_filesystem_name
  storage_account_id   = azurerm_storage_account.this.id
}

output "resource_group_name" {
  value = azurerm_resource_group.this.name
}

output "resource_group_id" {
  value = azurerm_resource_group.this.id
}

output "storage_account_name" {
  value = azurerm_storage_account.this.name
}

output "storage_account_id" {
  value = azurerm_storage_account.this.id
}

output "primary_key" {
  value     = azurerm_storage_account.this.primary_access_key
  sensitive = true
}

output "delta_path" {
  value = "abfss://${var.delta_filesystem_name}@${azurerm_storage_account.this.name}.dfs.core.windows.net/delta"
}

output "checkpoint_path" {
  value = "abfss://${var.delta_filesystem_name}@${azurerm_storage_account.this.name}.dfs.core.windows.net/checkpoints"
}

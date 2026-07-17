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

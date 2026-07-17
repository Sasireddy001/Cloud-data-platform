# Azure Databricks Module

resource "azurerm_databricks_workspace" "this" {
  name                = var.workspace_name
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = var.sku

  tags = var.tags
}

resource "azurerm_databricks_workspace_customer_managed_key" "this" {
  count = var.customer_managed_key_enabled ? 1 : 0

  workspace_id            = azurerm_databricks_workspace.this.id
  key_vault_id            = var.key_vault_id
  key_vault_key_name      = var.key_vault_key_name
  key_vault_key_version   = var.key_vault_key_version
}

resource "azurerm_databricks_workspace_vnet_peering" "this" {
  count = var.vnet_peering_enabled ? 1 : 0

  name                       = "${var.workspace_name}-vnet-peering"
  workspace_id               = azurerm_databricks_workspace.this.id
  virtual_network_id         = var.vnet_id
  remote_virtual_network_id  = var.databricks_vnet_id
}

output "workspace_name" {
  value = azurerm_databricks_workspace.this.name
}

output "workspace_id" {
  value = azurerm_databricks_workspace.this.id
}

output "workspace_url" {
  value = azurerm_databricks_workspace.this.workspace_url
}

output "databricks_host" {
  value = "https://${azurerm_databricks_workspace.this.workspace_url}"
}

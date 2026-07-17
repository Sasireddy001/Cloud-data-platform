# Azure Event Hub Module

resource "azurerm_eventhub_namespace" "this" {
  name                = var.namespace_name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = var.sku
  capacity            = var.capacity

  tags = var.tags
}

resource "azurerm_eventhub" "this" {
  name                = var.event_hub_name
  namespace_name      = azurerm_eventhub_namespace.this.name
  resource_group_name = var.resource_group_name
  partition_count     = var.partition_count
  message_retention   = var.message_retention

  capture_description {
    name             = "capture"
    destination_name = azurerm_eventhub_capture_destination.this.name
    enabled          = true
    encoding         = "Avro"
    interval_seconds = 300
    size_limit_in_bytes = 314572800
  }
}

resource "azurerm_eventhub_capture_destination" "this" {
  name                = "capture"
  resource_group_name = var.resource_group_name
  namespace_name      = azurerm_eventhub_namespace.this.name
  eventhub_name       = azurerm_eventhub.this.name

  blob_capturing_storage_account_id = var.storage_account_id
  blob_capturing_container_name      = var.storage_container_name
}

resource "azurerm_eventhub_consumer_group" "this" {
  name                = var.consumer_group_name
  namespace_name      = azurerm_eventhub_namespace.this.name
  eventhub_name       = azurerm_eventhub.this.name
  resource_group_name = var.resource_group_name
}

resource "azurerm_eventhub_authorization_rule" "this" {
  name                = var.authorization_rule_name
  namespace_name      = azurerm_eventhub_namespace.this.name
  eventhub_name       = azurerm_eventhub.this.name
  resource_group_name = var.resource_group_name

  listen = true
  send   = true
  manage = false
}

output "namespace_name" {
  value = azurerm_eventhub_namespace.this.name
}

output "event_hub_name" {
  value = azurerm_eventhub.this.name
}

output "connection_string" {
  value     = azurerm_eventhub_authorization_rule.this.primary_connection_string
  sensitive = true
}

output "namespace_id" {
  value = azurerm_eventhub_namespace.this.id
}

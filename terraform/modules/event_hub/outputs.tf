# Outputs for Azure Event Hub Module

output "namespace_name" {
  description = "Name of the Event Hubs namespace"
  value       = azurerm_eventhub_namespace.this.name
}

output "namespace_id" {
  description = "ID of the Event Hubs namespace"
  value       = azurerm_eventhub_namespace.this.id
}

output "event_hub_name" {
  description = "Name of the Event Hub"
  value       = azurerm_eventhub.this.name
}

output "event_hub_id" {
  description = "ID of the Event Hub"
  value       = azurerm_eventhub.this.id
}

output "connection_string" {
  description = "Connection string for the Event Hub (sensitive)"
  value       = azurerm_eventhub_authorization_rule.this.primary_connection_string
  sensitive   = true
}

output "primary_key" {
  description = "Primary key for the Event Hub (sensitive)"
  value       = azurerm_eventhub_authorization_rule.this.primary_key
  sensitive   = true
}

output "consumer_group_name" {
  description = "Name of the consumer group"
  value       = azurerm_eventhub_consumer_group.this.name
}

# Development environment configuration

# Resource group
resource_group_name = "cloud-data-platform-rg-dev"
location            = "eastus"

# Storage
storage_account_name     = "clouddataplatstgdev"
account_replication_type = "LRS"
delta_container_name     = "delta"
checkpoint_container_name = "checkpoints"
capture_container_name   = "capture"
delta_filesystem_name    = "delta"

# Event Hub
event_hub_namespace_name = "cloud-event-hubs-ns-dev"
event_hub_name          = "events"
partition_count         = 2
message_retention       = 7
consumer_group_name     = "$Default"
authorization_rule_name = "RootManageSharedAccessKey"
event_hub_sku           = "Standard"
event_hub_capacity      = 1

# Databricks
databricks_workspace_name = "cloud-databricks-ws-dev"
databricks_sku            = "premium"

# Tags
tags = {
  Project     = "Cloud Data Platform"
  ManagedBy   = "Terraform"
  Environment = "dev"
}

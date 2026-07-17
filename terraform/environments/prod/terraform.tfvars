# Production environment configuration

# Resource group
resource_group_name = "cloud-data-platform-rg-prod"
location            = "eastus"

# Storage
storage_account_name     = "clouddataplatstgprod"
account_replication_type = "GRS"
delta_container_name     = "delta"
checkpoint_container_name = "checkpoints"
capture_container_name   = "capture"
delta_filesystem_name    = "delta"

# Event Hub
event_hub_namespace_name = "cloud-event-hubs-ns-prod"
event_hub_name          = "events"
partition_count         = 4
message_retention       = 30
consumer_group_name     = "$Default"
authorization_rule_name = "RootManageSharedAccessKey"
event_hub_sku           = "Standard"
event_hub_capacity      = 2

# Databricks
databricks_workspace_name = "cloud-databricks-ws-prod"
databricks_sku            = "premium"

# Tags
tags = {
  Project     = "Cloud Data Platform"
  ManagedBy   = "Terraform"
  Environment = "prod"
}

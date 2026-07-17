# Main Terraform configuration
# This is the root module that orchestrates all sub-modules

terraform {
  required_version = ">= 1.5.0"
  
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
  
  # Use local backend by default. For production, configure remote backend
  # with Azure Storage or Terraform Cloud by uncommenting and filling backend block below.
  # backend "azurerm" {
  #   resource_group_name  = "tfstate-rg"
  #   storage_account_name = "tfstatestorage"
  #   container_name       = "tfstate"
  #   key                  = "cloud-data-platform.tfstate"
  # }
}

provider "azurerm" {
  features {}
}

# Storage module (includes resource group)
module "storage" {
  source = "./modules/storage"

  resource_group_name     = var.resource_group_name
  location                = var.location
  storage_account_name    = var.storage_account_name
  account_replication_type = var.account_replication_type
  delta_container_name   = var.delta_container_name
  checkpoint_container_name = var.checkpoint_container_name
  capture_container_name  = var.capture_container_name
  delta_filesystem_name   = var.delta_filesystem_name

  tags = var.tags
}

# Event Hub module
module "event_hub" {
  source = "./modules/event_hub"

  namespace_name           = var.event_hub_namespace_name
  location                = var.location
  resource_group_name     = module.storage.resource_group_name
  event_hub_name          = var.event_hub_name
  partition_count         = var.partition_count
  message_retention       = var.message_retention
  consumer_group_name     = var.consumer_group_name
  authorization_rule_name = var.authorization_rule_name
  storage_account_id      = module.storage.storage_account_id
  storage_container_name  = var.capture_container_name

  sku     = var.event_hub_sku
  capacity = var.event_hub_capacity

  tags = var.tags
}

# Databricks module
module "databricks" {
  source = "./modules/databricks"

  resource_group_name = module.storage.resource_group_name
  location            = var.location
  workspace_name      = var.databricks_workspace_name
  sku                 = var.databricks_sku

  tags = var.tags
}

# Variables are defined in variables.tf

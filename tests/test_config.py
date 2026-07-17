"""Tests for configuration module."""
import os
from config import CloudConfig


def test_config_from_env_with_defaults():
    """Test config loading with default values."""
    os.environ["EVENT_HUB_CONNECTION_STRING"] = "test_connection_string"
    os.environ["DATABRICKS_HOST"] = "https://test.cloud.databricks.com"
    os.environ["DATABRICKS_TOKEN"] = "test_token"
    os.environ["STORAGE_ACCOUNT_NAME"] = "teststorage"
    os.environ["STORAGE_ACCOUNT_KEY"] = "test_key"
    
    config = CloudConfig.from_env()
    
    assert config.event_hub_namespace_name == "cloud-event-hubs-ns"
    assert config.event_hub_name == "events"
    assert config.event_hub_connection_string == "test_connection_string"
    assert config.consumer_group_name == "$Default"
    assert config.databricks_host == "https://test.cloud.databricks.com"
    assert config.databricks_token == "test_token"
    assert config.storage_account_name == "teststorage"
    assert config.storage_account_key == "test_key"
    assert config.trigger_interval == "10 seconds"
    assert config.max_offsets_per_trigger == 10000
    assert config.watermark_seconds == 120


def test_config_from_env_with_overrides():
    """Test config loading with environment variable overrides."""
    os.environ["EVENT_HUB_NAMESPACE_NAME"] = "custom-namespace"
    os.environ["EVENT_HUB_NAME"] = "custom-events"
    os.environ["EVENT_HUB_CONNECTION_STRING"] = "custom_connection_string"
    os.environ["EVENT_HUB_CONSUMER_GROUP"] = "custom-consumer"
    os.environ["DATABRICKS_HOST"] = "https://custom.cloud.databricks.com"
    os.environ["DATABRICKS_TOKEN"] = "custom_token"
    os.environ["DATABRICKS_CLUSTER_ID"] = "custom-cluster"
    os.environ["STORAGE_ACCOUNT_NAME"] = "customstorage"
    os.environ["STORAGE_ACCOUNT_KEY"] = "custom_key"
    os.environ["DELTA_PATH"] = "custom/delta/path"
    os.environ["CHECKPOINT_PATH"] = "custom/checkpoint/path"
    os.environ["TRIGGER_INTERVAL"] = "30 seconds"
    os.environ["MAX_OFFSETS_PER_TRIGGER"] = "50000"
    os.environ["WATERMARK_SECONDS"] = "300"
    
    config = CloudConfig.from_env()
    
    assert config.event_hub_namespace_name == "custom-namespace"
    assert config.event_hub_name == "custom-events"
    assert config.event_hub_connection_string == "custom_connection_string"
    assert config.consumer_group_name == "custom-consumer"
    assert config.databricks_host == "https://custom.cloud.databricks.com"
    assert config.databricks_token == "custom_token"
    assert config.databricks_cluster_id == "custom-cluster"
    assert config.storage_account_name == "customstorage"
    assert config.storage_account_key == "custom_key"
    assert config.delta_path == "custom/delta/path"
    assert config.checkpoint_path == "custom/checkpoint/path"
    assert config.trigger_interval == "30 seconds"
    assert config.max_offsets_per_trigger == 50000
    assert config.watermark_seconds == 300

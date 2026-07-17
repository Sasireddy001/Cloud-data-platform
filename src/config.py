"""Configuration for the cloud data platform."""
import os
from dataclasses import dataclass
from typing import Optional


@dataclass
class CloudConfig:
    """Configuration for cloud data platform."""

    # Event Hubs / MSK
    event_hub_namespace: str
    event_hub_name: str
    event_hub_connection_string: str

    # Databricks / EMR
    databricks_host: str
    databricks_token: str
    databricks_cluster_id: Optional[str] = None

    # Storage
    storage_account_name: str
    storage_account_key: str
    delta_path: str
    checkpoint_path: str

    # Streaming
    topic: str = "events"
    trigger_interval: str = "10 seconds"
    max_offsets_per_trigger: int = 10000
    watermark_seconds: int = 120

    @classmethod
    def from_env(cls) -> "CloudConfig":
        """Load configuration from environment variables."""
        return cls(
            event_hub_namespace=os.getenv("EVENT_HUB_NAMESPACE", "cloud-event-hubs-ns"),
            event_hub_name=os.getenv("EVENT_HUB_NAME", "events"),
            event_hub_connection_string=os.getenv("EVENT_HUB_CONNECTION_STRING"),
            databricks_host=os.getenv("DATABRICKS_HOST"),
            databricks_token=os.getenv("DATABRICKS_TOKEN"),
            databricks_cluster_id=os.getenv("DATABRICKS_CLUSTER_ID"),
            storage_account_name=os.getenv("STORAGE_ACCOUNT_NAME"),
            storage_account_key=os.getenv("STORAGE_ACCOUNT_KEY"),
            delta_path=os.getenv("DELTA_PATH", "abfss://delta@storageaccount.dfs.core.windows.net/events"),
            checkpoint_path=os.getenv("CHECKPOINT_PATH", "abfss://checkpoints@storageaccount.dfs.core.windows.net/events"),
            topic=os.getenv("KAFKA_TOPIC", "events"),
            trigger_interval=os.getenv("TRIGGER_INTERVAL", "10 seconds"),
            max_offsets_per_trigger=int(os.getenv("MAX_OFFSETS_PER_TRIGGER", "10000")),
            watermark_seconds=int(os.getenv("WATERMARK_SECONDS", "120")),
        )

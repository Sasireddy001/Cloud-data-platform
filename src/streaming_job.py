"""Streaming job for cloud data platform."""
import logging
from pyspark.sql import SparkSession
from pyspark.sql.functions import col, from_json, to_timestamp, current_timestamp, window, count
from pyspark.sql.types import StructType, StringType, TimestampType

from config import CloudConfig

# Configure logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

EVENT_SCHEMA = StructType().add("event_id", StringType()).add("data", StringType()).add("event_timestamp", TimestampType())


def create_spark_session(config: CloudConfig) -> SparkSession:
    """Create Spark session with Databricks configuration."""
    builder = SparkSession.builder.appName("CloudStreamingJob")
    
    # Configure for Databricks
    if config.databricks_host:
        builder = builder.config("spark.databricks.service.address", config.databricks_host)
        builder = builder.config("spark.databricks.service.token", config.databricks_token)
        if config.databricks_cluster_id:
            builder = builder.config("spark.databricks.service.clusterId", config.databricks_cluster_id)
    
    # Configure Delta Lake
    builder = builder.config("spark.sql.extensions", "io.delta.sql.DeltaSparkSessionExtension")
    builder = builder.config("spark.sql.catalog.spark_catalog", "org.apache.spark.sql.delta.catalog.DeltaCatalog")
    
    # Performance optimizations
    builder = builder.config("spark.sql.shuffle.partitions", "4")
    builder = builder.config("spark.sql.adaptive.enabled", "true")
    
    return builder.getOrCreate()


def main():
    """Main entry point for the streaming job."""
    config = CloudConfig.from_env()
    spark = create_spark_session(config)
    
    logger.info("Starting streaming job")
    logger.info(f"Event Hub Namespace: {config.event_hub_namespace_name}")
    logger.info(f"Event Hub Name: {config.event_hub_name}")
    logger.info(f"Delta Path: {config.delta_path}")
    
    # Read from Event Hubs
    df = (
        spark.readStream.format("eventhubs")
        .option("eventhubs.connectionString", config.event_hub_connection_string)
        .option("eventhubs.consumerGroup", config.consumer_group_name)
        .option("eventhubs.startingPosition", "earliest")
        .option("eventhubs.maxEventsPerTrigger", config.max_offsets_per_trigger)
        .load()
    )
    
    # Parse and transform
    parsed_df = df.select(
        from_json(col("body").cast("string"), EVENT_SCHEMA).alias("parsed")
    ).select("parsed.*")
    
    # Add partition columns and metadata
    enriched_df = parsed_df.withColumn(
        "event_date", to_timestamp(col("event_timestamp"), "yyyy-MM-dd")
    ).withColumn(
        "event_hour", to_timestamp(col("event_timestamp"), "yyyy-MM-dd HH")
    ).withColumn(
        "ingested_at", current_timestamp()
    )
    
    # Deduplicate using watermark
    deduplicated_df = enriched_df.withWatermark(
        "event_timestamp", f"{config.watermark_seconds} seconds"
    ).dropDuplicates(["event_id"])
    
    # Write to Delta Lake
    query = (
        deduplicated_df.writeStream.format("delta")
        .outputMode("append")
        .option("checkpointLocation", config.checkpoint_path)
        .partitionBy("event_date")
        .trigger(processingTime=config.trigger_interval)
        .start(config.delta_path)
    )
    
    logger.info("Streaming query started")
    logger.info(f"Trigger interval: {config.trigger_interval}")
    logger.info(f"Max offsets per trigger: {config.max_offsets_per_trigger}")
    
    query.awaitTermination()


if __name__ == "__main__":
    main()

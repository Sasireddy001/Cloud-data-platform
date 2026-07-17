"""Streaming job for cloud data platform."""
from pyspark.sql import SparkSession
from pyspark.sql.functions import col, from_json, to_timestamp
from pyspark.sql.types import StructType, StringType, TimestampType

from config import CloudConfig


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
    
    return builder.getOrCreate()


def main():
    """Main entry point for the streaming job."""
    config = CloudConfig.from_env()
    spark = create_spark_session(config)
    
    # Read from Event Hubs / Kafka
    df = (
        spark.readStream.format("eventhubs")
        .option("eventhubs.connectionString", config.event_hub_connection_string)
        .option("eventhubs.consumerGroup", "$DEFAULT")
        .option("eventhubs.startingPosition", "earliest")
        .load()
    )
    
    # Parse and transform
    parsed_df = df.select(
        from_json(col("body").cast("string"), EVENT_SCHEMA).alias("parsed")
    ).select("parsed.*")
    
    # Add partition columns
    enriched_df = parsed_df.withColumn(
        "event_date", to_timestamp(col("event_timestamp"), "yyyy-MM-dd")
    )
    
    # Write to Delta Lake
    query = (
        enriched_df.writeStream.format("delta")
        .outputMode("append")
        .option("checkpointLocation", config.checkpoint_path)
        .partitionBy("event_date")
        .start(config.delta_path)
    )
    
    query.awaitTermination()


if __name__ == "__main__":
    main()

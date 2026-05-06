Snowflake Asset Validation Workflow
Architecture Overview

This project simulates a production-style Snowflake ETL validation workflow using AWS DMS, staged parquet files, infer schema automation, COPY INTO operations, validation queries, and scheduled tasks.

Workflow Steps
AWS DMS migrates source data
Parquet files are staged for ingestion
Snowflake INFER_SCHEMA generates table structures
COPY INTO loads parquet data into Snowflake tables
Validation queries confirm row counts and ingestion success
Scheduled tasks automate downstream execution
Task timing dependencies are monitored to prevent premature execution
Technologies Used
Snowflake
SQL
AWS DMS
Parquet files
Scheduled Tasks
Validation Queries
ETL Monitoring

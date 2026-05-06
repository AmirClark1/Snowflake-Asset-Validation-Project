# Snowflake Asset Validation Project

This project demonstrates a Snowflake ETL validation workflow using AWS DMS, staged parquet files, infer schema automation, COPY INTO operations, validation queries, and scheduled Snowflake tasks.

> Note: This is a sanitized portfolio version. Internal database names, account identifiers, email addresses, and sensitive business logic have been generalized.

---

# Project Overview

The workflow simulates a production-style cloud data engineering pipeline where:

1. AWS DMS loads source data
2. Parquet files are staged in Snowflake
3. Infer schema generates table structures
4. COPY INTO loads the data
5. Validation queries verify ingestion success
6. Scheduled tasks automate downstream processing
7. Task timing dependencies are monitored to avoid premature execution

This project reflects real-world ETL validation and operational monitoring workflows.

---

# Technologies Used

- Snowflake
- SQL
- AWS DMS
- Parquet
- Snowflake Tasks
- Infer Schema
- COPY INTO
- Data Validation Queries
- ETL Monitoring
- GitHub

---

# Workflow Architecture

## AWS DMS Load Process

AWS Database Migration Service (DMS) loads source system data into Snowflake staging locations.

Key operational considerations:
- Load timing
- Full load completion
- Validation of row counts
- Downstream dependency timing

---

## Infer Schema Automation

The project uses Snowflake `INFER_SCHEMA` functionality to dynamically generate table definitions from staged parquet files.

Example:

```sql
CREATE OR REPLACE TABLE FDC_Shifts
USING TEMPLATE (
    SELECT ARRAY_AGG(OBJECT_CONSTRUCT(*))
    FROM TABLE(
        INFER_SCHEMA(
            LOCATION=>'@parquet_stage/FDC_Shifts/',
            FILE_FORMAT=>'parquet_format',
            IGNORE_CASE=>TRUE
        )
    )
)
ENABLE_SCHEMA_EVOLUTION = TRUE;
```

---

## COPY INTO Operations

After schema creation, parquet data is loaded into Snowflake tables using COPY INTO commands.

Example:

```sql
COPY INTO FDC_Shifts
FROM @parquet_stage/FDC_Shifts/
FILE_FORMAT = (
    TYPE = 'PARQUET',
    REPLACE_INVALID_CHARACTERS = TRUE,
    BINARY_AS_TEXT = FALSE
)
MATCH_BY_COLUMN_NAME = CASE_INSENSITIVE;
```

---

## Validation Queries

Validation queries are used after ingestion to verify:

- Row counts
- Data availability
- Successful task execution
- ETL completion

Example validation query:

```sql
SELECT COUNT(*)
FROM FDC_Shifts;
```

---

## Task Scheduling & Timing Dependencies

A key operational consideration in this workflow is ensuring that Snowflake tasks do not execute before AWS DMS loads have completed.

Example:
- AWS DMS load starts at 2:00 AM
- Snowflake task executes at 3:00 AM
- This timing buffer helps prevent incomplete downstream processing

Example task:

```sql
CREATE OR REPLACE TASK T_EPCRDBOLOAD
WAREHOUSE = COT_ETL
SCHEDULE = 'USING CRON 0 3 * * * America/Phoenix'
AS

CALL SP_EPCRLOAD();
```

---

# Lessons Learned

During this project I gained hands-on experience with:

- Snowflake task scheduling
- ETL timing dependencies
- AWS DMS operational monitoring
- Schema automation using infer schema
- Parquet ingestion workflows
- Validation query development
- Production-style troubleshooting
- Coordinating cloud data workflows

---

# Repository Structure

```text
Snowflake-Asset-Validation-Project/
│
├── README.md
├── .gitignore
│
├── sql/
│   ├── infer_schema_examples.sql
│   ├── copy_into_commands.sql
│   ├── validation_queries.sql
│   ├── task_execution.sql
│   └── task_schedule_example.sql
│
├── screenshots/
│
└── docs/
    └── architecture_overview.md
```

---

# Future Improvements

Potential future enhancements include:

- Automated monitoring dashboards
- Snowflake alert integrations
- Data quality scorecards
- Incremental load validation
- Error notification workflows
- Pipeline orchestration enhancements

---

# Author

Amir Clark  
Cloud Data Engineering SkillBridge Intern  
U.S. Air Force Veteran Transitioning into Cloud & Data Engineering

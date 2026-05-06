-- Example: Infer schema from staged parquet files

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

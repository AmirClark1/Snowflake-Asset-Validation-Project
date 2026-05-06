-- Example COPY INTO command for loading parquet data

COPY INTO FDC_Shifts
FROM @parquet_stage/FDC_Shifts/
FILE_FORMAT = (
    TYPE = 'PARQUET',
    REPLACE_INVALID_CHARACTERS = TRUE,
    BINARY_AS_TEXT = FALSE
)
MATCH_BY_COLUMN_NAME = CASE_INSENSITIVE;

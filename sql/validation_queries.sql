-- Validation queries used after ETL loads

SELECT COUNT(*)
FROM FDC_Shifts;

SELECT *
FROM FDC_Shifts
LIMIT 100;

SELECT CURRENT_TIMESTAMP();

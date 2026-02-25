CREATE OR REPLACE VIEW `readmissions-488017.readmissions.stg_hrrp` AS
SELECT
  -- normalize Facility ID to 6-char string like 010001
  LPAD(CAST(SAFE_CAST(`Facility ID` AS INT64) AS STRING), 6, '0') AS facility_id_norm,

  TRIM(CAST(`Facility Name` AS STRING)) AS facility_name_hrrp,
  TRIM(CAST(State AS STRING)) AS state,
  TRIM(CAST(`Measure Name` AS STRING)) AS measure_name,

  SAFE_CAST(`Number of Discharges` AS INT64) AS discharges,
  SAFE_CAST(`Excess Readmission Ratio` AS FLOAT64) AS excess_ratio,
  SAFE_CAST(`Predicted Readmission Rate` AS FLOAT64) AS predicted_rate,
  SAFE_CAST(`Expected Readmission Rate` AS FLOAT64) AS expected_rate,

  -- "Too Few to Report" becomes NULL via SAFE_CAST
  SAFE_CAST(`Number of Readmissions` AS INT64) AS readmissions,

  SAFE.PARSE_DATE('%m/%d/%Y', CAST(`Start Date` AS STRING)) AS start_date,
  SAFE.PARSE_DATE('%m/%d/%Y', CAST(`End Date` AS STRING)) AS end_date,

  IF(SAFE_CAST(`Number of Readmissions` AS INT64) IS NULL, 1, 0) AS suppressed_flag
FROM `readmissions-488017.readmissions.raw_hrrp_2025`;

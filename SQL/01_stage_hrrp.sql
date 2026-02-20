CREATE OR REPLACE VIEW `YOUR_PROJECT.readmissions.stg_hrrp` AS
SELECT
  -- HRRP file has Facility ID as int -> normalize to 6-char string like 010001
  LPAD(CAST(SAFE_CAST(`Facility ID` AS INT64) AS STRING), 6, '0') AS facility_id_norm,

  TRIM(`Facility Name`) AS facility_name_hrrp,
  TRIM(State) AS state,
  TRIM(`Measure Name`) AS measure_name,

  SAFE_CAST(`Number of Discharges` AS INT64) AS discharges,
  SAFE_CAST(`Excess Readmission Ratio` AS FLOAT64) AS excess_ratio,
  SAFE_CAST(`Predicted Readmission Rate` AS FLOAT64) AS predicted_rate,
  SAFE_CAST(`Expected Readmission Rate` AS FLOAT64) AS expected_rate,

  -- "Too Few to Report" -> NULL
  SAFE_CAST(`Number of Readmissions` AS INT64) AS readmissions,

  PARSE_DATE('%m/%d/%Y', `Start Date`) AS start_date,
  PARSE_DATE('%m/%d/%Y', `End Date`) AS end_date,

  CASE WHEN SAFE_CAST(`Number of Readmissions` AS INT64) IS NULL THEN 1 ELSE 0 END AS suppressed_flag
FROM `YOUR_PROJECT.readmissions.raw_hrrp_2025`;

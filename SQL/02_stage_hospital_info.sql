CREATE OR REPLACE VIEW `readmissions-488017.readmissions.stg_hospital_info` AS
SELECT
  LPAD(TRIM(CAST(`Facility ID` AS STRING)), 6, '0') AS facility_id_norm,
  TRIM(CAST(`Facility Name` AS STRING)) AS facility_name,
  TRIM(CAST(State AS STRING)) AS state,
  TRIM(CAST(`Hospital Type` AS STRING)) AS hospital_type,
  TRIM(CAST(`Hospital Ownership` AS STRING)) AS hospital_ownership,

  -- Emergency Services is BOOL in BigQuery: do NOT TRIM it
  CASE
    WHEN `Emergency Services` IS TRUE THEN 'Yes'
    WHEN `Emergency Services` IS FALSE THEN 'No'
    ELSE NULL
  END AS emergency_services,

  SAFE_CAST(`Hospital overall rating` AS INT64) AS overall_rating,

  SAFE_CAST(`Count of Facility READM Measures` AS INT64) AS readm_measures_count,
  SAFE_CAST(`Count of READM Measures Better` AS INT64) AS readm_better,
  SAFE_CAST(`Count of READM Measures No Different` AS INT64) AS readm_no_diff,
  SAFE_CAST(`Count of READM Measures Worse` AS INT64) AS readm_worse
FROM `readmissions-488017.readmissions.raw_hospital_info`;

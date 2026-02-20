CREATE OR REPLACE VIEW `YOUR_PROJECT.readmissions.stg_hospital_info` AS
SELECT
  LPAD(TRIM(CAST(`Facility ID` AS STRING)), 6, '0') AS facility_id_norm,
  TRIM(`Facility Name`) AS facility_name,
  TRIM(State) AS state,
  TRIM(`Hospital Type`) AS hospital_type,
  TRIM(`Hospital Ownership`) AS hospital_ownership,
  TRIM(`Emergency Services`) AS emergency_services,

  -- overall rating sometimes stored as text; keep numeric when possible
  SAFE_CAST(`Hospital overall rating` AS INT64) AS overall_rating,

  -- READM summary counts (already in this file)
  SAFE_CAST(`Count of Facility READM Measures` AS INT64) AS readm_measures_count,
  SAFE_CAST(`Count of READM Measures Better` AS INT64) AS readm_better,
  SAFE_CAST(`Count of READM Measures No Different` AS INT64) AS readm_no_diff,
  SAFE_CAST(`Count of READM Measures Worse` AS INT64) AS readm_worse

FROM `YOUR_PROJECT.readmissions.raw_hospital_info`;

CREATE OR REPLACE VIEW `readmissions-488017.readmissions.mart_hrrp_joined` AS
SELECT
  r.facility_id_norm,
  COALESCE(h.facility_name, r.facility_name_hrrp) AS facility_name,
  COALESCE(h.state, r.state) AS state,

  -- hospital attributes
  h.hospital_type,
  h.hospital_ownership,
  h.emergency_services,
  h.overall_rating,
  h.readm_measures_count,
  h.readm_better,
  h.readm_no_diff,
  h.readm_worse,

  -- HRRP metrics by measure
  r.measure_name,
  r.discharges,
  r.readmissions,
  r.excess_ratio,
  r.predicted_rate,
  r.expected_rate,
  r.start_date,
  r.end_date,
  r.suppressed_flag

FROM `readmissions-488017.readmissions.stg_hrrp` r
LEFT JOIN (
  SELECT
    facility_id_norm,
    ANY_VALUE(facility_name) AS facility_name,
    ANY_VALUE(state) AS state,
    ANY_VALUE(hospital_type) AS hospital_type,
    ANY_VALUE(hospital_ownership) AS hospital_ownership,
    ANY_VALUE(emergency_services) AS emergency_services,
    ANY_VALUE(overall_rating) AS overall_rating,
    ANY_VALUE(readm_measures_count) AS readm_measures_count,
    ANY_VALUE(readm_better) AS readm_better,
    ANY_VALUE(readm_no_diff) AS readm_no_diff,
    ANY_VALUE(readm_worse) AS readm_worse
  FROM `readmissions-488017.readmissions.stg_hospital_info`
  GROUP BY facility_id_norm
) h
USING (facility_id_norm);

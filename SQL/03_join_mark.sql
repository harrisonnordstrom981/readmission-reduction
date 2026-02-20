CREATE OR REPLACE VIEW `YOUR_PROJECT.readmissions.mart_hrrp_joined` AS
SELECT
  h.facility_id_norm,
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

FROM `YOUR_PROJECT.readmissions.stg_hrrp` r
LEFT JOIN `YOUR_PROJECT.readmissions.stg_hospital_info` h
  USING (facility_id_norm);

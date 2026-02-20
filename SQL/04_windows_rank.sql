WITH per_hosp AS (
  SELECT
    facility_id_norm,
    ANY_VALUE(facility_name) AS facility_name,
    ANY_VALUE(state) AS state,
    ANY_VALUE(overall_rating) AS overall_rating,
    AVG(excess_ratio) AS avg_excess_ratio_across_measures,
    SUM(CASE WHEN excess_ratio > 1 THEN 1 ELSE 0 END) AS measures_above_1,
    COUNTIF(excess_ratio IS NOT NULL) AS measures_reported
  FROM `YOUR_PROJECT.readmissions.mart_hrrp_joined`
  WHERE suppressed_flag = 0
  GROUP BY facility_id_norm
)
SELECT
  *,
  RANK() OVER (PARTITION BY state ORDER BY avg_excess_ratio_across_measures DESC) AS rank_in_state_overall
FROM per_hosp
ORDER BY avg_excess_ratio_across_measures DESC;

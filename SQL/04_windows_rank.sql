WITH per_hosp AS (
  SELECT
    facility_id_norm,
    ANY_VALUE(facility_name) AS facility_name,
    ANY_VALUE(state) AS state,
    ANY_VALUE(overall_rating) AS overall_rating,

    AVG(excess_ratio) AS avg_excess_ratio_across_measures,
    SUM(CASE WHEN excess_ratio > 1 THEN 1 ELSE 0 END) AS measures_above_1,
    COUNTIF(excess_ratio IS NOT NULL) AS measures_reported,

    SAFE_DIVIDE(
      SUM(CASE WHEN excess_ratio > 1 THEN 1 ELSE 0 END),
      COUNTIF(excess_ratio IS NOT NULL)
    ) AS pct_measures_above_1
  FROM `readmissions-488017.readmissions.mart_hrrp_joined`
  WHERE SAFE_CAST(suppressed_flag AS INT64) = 0
  GROUP BY facility_id_norm
  HAVING COUNTIF(excess_ratio IS NOT NULL) > 0
)

SELECT
  facility_id_norm,
  facility_name,
  state,
  overall_rating,
  avg_excess_ratio_across_measures,
  measures_reported,
  measures_above_1,
  pct_measures_above_1,
  CASE
    WHEN avg_excess_ratio_across_measures > 1 THEN 'Higher-than-expected readmissions'
    ELSE 'At-or-better than expected'
  END AS risk_flag,
  DENSE_RANK() OVER (
    PARTITION BY state
    ORDER BY avg_excess_ratio_across_measures DESC
  ) AS rank_in_state_overall
FROM per_hosp
ORDER BY avg_excess_ratio_across_measures DESC;

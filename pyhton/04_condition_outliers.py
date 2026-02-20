"""
04_condition_outliers_optional.py
Optional: Pull condition-level outliers from the joined mart and export top outliers.
Requires your SQL mart table exists (mart_hrrp_joined).
"""

import os
import pandas as pd
from google.cloud import bigquery
from 00_config import CFG, bq_table

QUERY = f"""
SELECT
  state,
  measure_name,
  facility_id_norm,
  facility_name,
  excess_ratio,
  predicted_rate,
  expected_rate,
  discharges
FROM {bq_table(CFG.mart_table)}
WHERE suppressed_flag = 0
  AND excess_ratio IS NOT NULL
  AND discharges IS NOT NULL
  AND discharges >= 50
QUALIFY
  RANK() OVER (PARTITION BY state, measure_name ORDER BY excess_ratio DESC) <= 10
ORDER BY state, measure_name, excess_ratio DESC
"""

def main() -> None:
    os.makedirs(CFG.out_dir, exist_ok=True)
    client = bigquery.Client(project=CFG.project_id)
    df = client.query(QUERY).to_dataframe(create_bqstorage_client=True)

    out_path = os.path.join(CFG.out_dir, "top10_outliers_by_state_measure.csv")
    df.to_csv(out_path, index=False)
    print(f"Saved {len(df):,} rows to {out_path}")

if __name__ == "__main__":
    main()

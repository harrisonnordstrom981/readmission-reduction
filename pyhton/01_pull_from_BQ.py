"""
01_pull_from_bigquery.py
Pulls hospital risk score dataset from BigQuery and saves to outputs/.
"""

import os
import pandas as pd
from google.cloud import bigquery
from 00_config import CFG, bq_table

QUERY = f"""
SELECT
  facility_id_norm,
  facility_name,
  state,
  overall_rating,
  hospital_type,
  hospital_ownership,
  emergency_services,
  avg_excess_ratio_across_measures AS avg_excess_ratio,
  measures_above_1,
  measures_reported,
  rank_in_state_overall
FROM {bq_table(CFG.hosp_risk_table)}
"""

def main() -> None:
    os.makedirs(CFG.out_dir, exist_ok=True)

    client = bigquery.Client(project=CFG.project_id)
    df = client.query(QUERY).to_dataframe(create_bqstorage_client=True)

    out_path = os.path.join(CFG.out_dir, "per_hospital_risk_score.csv")
    df.to_csv(out_path, index=False)

    print(f"Saved {len(df):,} rows to {out_path}")
    print(df.head(5).to_string(index=False))

if __name__ == "__main__":
    main()

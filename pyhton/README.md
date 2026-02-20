# Python Analysis (CMS HRRP Readmissions Project)

## What this does
- Pulls the final hospital-level risk score dataset from BigQuery
- Produces EDA tables + plots for conclusions
- Trains a simple classifier to predict “high-risk” hospitals (avg excess ratio > 1)

## Files
- `01_pull_from_bigquery.py` -> exports `outputs/per_hospital_risk_score.csv`
- `02_eda_and_conclusions.py` -> exports summary tables + plots + regression output
- `03_model_high_risk.py` -> exports classification metrics + feature importance
- `04_condition_outliers_optional.py` -> optional outlier extraction by condition

## Running
1. Install requirements:
   ```bash
   pip install -r requirements.txt

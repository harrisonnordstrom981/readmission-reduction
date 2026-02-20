# Project Title

## Overview
This project uses BigQuery SQL to transform raw data into analysis-ready tables/views and generate insights.

## Tech Stack
- BigQuery (SQL)
- (Optional later) Python / Tableau

## Repo Structure
- `sql/00_setup.sql` – dataset setup
- `sql/01_staging.sql` – staging layer (type cleaning)
- `sql/02_clean_views.sql` – clean analysis-ready views
- `sql/03_analysis.sql` – starter analysis queries
- `sql/99_quality_checks.sql` – QA checks

## How to Run
1. Run `sql/00_setup.sql`
2. Load data into `raw_*` tables
3. Run `sql/01_staging.sql` → `sql/02_clean_views.sql`
4. Run `sql/03_analysis.sql` for insights

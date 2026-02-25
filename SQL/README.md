# SQL – Hospital Readmission Risk Analysis

## Overview

These SQL scripts were developed in **Google BigQuery** to clean and analyze CMS Hospital Readmissions Reduction Program (HRRP) data. The pipeline transforms raw hospital and readmission data into analytics-ready tables used for Tableau dashboards and further analysis.

**Project:** `readmissions-488017`  
**Dataset:** `readmissions`

---

## Data Sources

**Raw Tables**

- `readmissions.raw_hrrp_2025` – HRRP readmission measures  
- `readmissions.raw_hospital_info` – Hospital attributes and ratings

---

## SQL Pipeline

Run scripts in this order:

### 1. stg_hrrp.sql

Creates:
- Cleans HRRP readmission data
- Normalizes Facility ID for joining
- Converts numeric fields with SAFE_CAST
- Parses date fields
- Flags suppressed rows

---

### 2. stg_hospital_info.sql

Creates:
- Cleans hospital attribute data
- Normalizes Facility ID
- Converts ratings to numeric values
- Casts Emergency Services from BOOL to STRING

---

### 3. mart_hrrp_joined.sql

Creates:
- Joins HRRP measures with hospital attributes
- Produces a unified dataset for analysis
- Maintains one row per hospital per measure

---

### 4. hospital_risk_analysis.sql

- Aggregates data to the hospital level
- Calculates average readmission risk
- Counts measures above expected levels
- Ranks hospitals within each state

Example window function:


---

## Risk Interpretation

Readmission performance is measured using the **Excess Readmission Ratio** (r): 

- r > 1  → Higher-than-expected readmissions  
- r = 1  → Expected readmissions  
- r < 1  → Lower-than-expected readmissions

Higher values indicate worse performance.

---

## SQL Techniques Demonstrated

- Data cleaning with SAFE_CAST
- Date parsing
- Multi-table joins
- Aggregations
- Window functions
- Ranking functions

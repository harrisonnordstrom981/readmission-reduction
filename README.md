# Hospital Readmission Risk Analysis

## Overview

This project analyzes hospital readmission performance using data from the CMS Hospital Readmissions Reduction Program (HRRP). The goal was to identify patterns in hospital readmission risk and explore how performance varies across hospital ratings, ownership types, and geographic regions.

The project uses **BigQuery SQL** for data cleaning and transformation and **Tableau** for visualization and dashboard development.

This project demonstrates an end-to-end analytics workflow including data cleaning, joins, aggregation, window functions, and dashboard design.

---

## Tools Used

- **Google BigQuery**
  - Data cleaning and transformation
  - Multi-table joins
  - Aggregations
  - Window functions

- **Tableau**
  - Data visualization
  - Dashboard design
  - Geographic analysis

- **SQL Techniques**
  - SAFE_CAST data cleaning
  - Date parsing
  - Aggregations
  - Window functions
  - Ranking functions

---

## Data Sources

**CMS Hospital Readmissions Reduction Program (HRRP)**

Datasets used:

- Hospital Readmission Measures
- Hospital General Information

These datasets include hospital attributes and readmission metrics across multiple medical conditions.

---

## SQL Pipeline

The SQL pipeline was developed in **Google BigQuery** and consists of four main steps:

### 1. HRRP Staging View

Creates a cleaned version of HRRP readmission data.

- Normalizes hospital identifiers
- Converts numeric fields
- Parses dates
- Flags suppressed rows

### 2. Hospital Info Staging View

Creates a cleaned hospital attributes table.

- Normalizes hospital identifiers
- Converts rating values to numeric format
- Standardizes ownership and hospital type fields

### 3. Joined Data Mart

Joins readmission metrics with hospital attributes.

This dataset contains:

- Hospital ratings
- Ownership types
- Geographic information
- Readmission metrics

### 4. Hospital Risk Analysis

Aggregates data to the hospital level and calculates readmission risk.

Key calculations:

- Average Excess Readmission Ratio
- Measures above expected readmissions
- Measures reported
- Hospital ranking within each state

Window functions were used to rank hospitals by readmission risk.

---

## Dashboard

### Hospital Readmission Risk Analysis Dashboard

<img width="949" height="627" alt="image" src="https://github.com/user-attachments/assets/6ec7717a-2417-4d68-8887-2683846f96b4" />


The Tableau dashboard explores hospital readmission risk across several dimensions.

---

### Readmission Risk by Hospital Rating

<img width="496" height="287" alt="image" src="https://github.com/user-attachments/assets/b0d1d927-89fc-44e5-882f-5cdb2b1e927d" />


Higher-rated hospitals generally show lower readmission risk.

---

### Readmission Risk by Hospital Ownership

<img width="492" height="337" alt="image" src="https://github.com/user-attachments/assets/4542ae9c-0e3f-4172-b83c-1f8cb9590575" />


Ownership type shows small but measurable differences in readmission risk.

---

### Readmission Risk by State

<img width="439" height="263" alt="image" src="https://github.com/user-attachments/assets/a6522247-6207-457f-bcc4-c440307d20fd" />


Readmission risk varies geographically across states.

---

## Key Findings

- Hospitals with higher quality ratings tend to have lower readmission risk
- Most hospitals cluster near an excess readmission ratio of 1.0
- Ownership types show small differences in average readmission risk
- Geographic variation exists across states

---

## Risk Interpretation

Hospital performance is measured using the **Excess Readmission Ratio**:

- Greater than 1 → Higher-than-expected readmissions
- Equal to 1 → Expected readmissions
- Less than 1 → Lower-than-expected readmissions

Higher values indicate worse readmission performance.

---

## Skills Demonstrated

- SQL data cleaning and transformation
- BigQuery analytics workflows
- Data modeling
- Window functions
- Data visualization
- Dashboard development
- Healthcare data analysis

---

## Author

Harrison Nordstrom  
 - Economics Student – Virginia Tech Class of 2026
 - nordstromharrison@gmail.com
 - www.linkedin.com/in/nordstromharrison

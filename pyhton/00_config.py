"""
00_config.py
Central config so you only edit names in one place.
"""

from dataclasses import dataclass
import os
from dotenv import load_dotenv

load_dotenv()  # loads .env if present

@dataclass(frozen=True)
class Config:
    # BigQuery
    project_id: str = os.getenv("BQ_PROJECT_ID", "YOUR_PROJECT")
    dataset: str = os.getenv("BQ_DATASET", "readmissions")

    # This should be your Option C output (view/table)
    # Example: hosp_risk_score (recommended)
    hosp_risk_table: str = os.getenv("BQ_HOSP_RISK_TABLE", "hosp_risk_score")

    # Optional: joined mart (condition-level) if you want extra analysis
    mart_table: str = os.getenv("BQ_MART_TABLE", "mart_hrrp_joined")

    # Local outputs
    out_dir: str = os.getenv("OUT_DIR", "outputs")

CFG = Config()

def bq_table(plain_name: str) -> str:
    """Build a fully-qualified BigQuery table name."""
    return f"`{CFG.project_id}.{CFG.dataset}.{plain_name}`"

"""
03_model_high_risk.py
Predict high-risk hospitals (avg_excess_ratio > 1) from hospital attributes.
Outputs metrics + feature importance.
"""

import os
import pandas as pd
import numpy as np

from sklearn.model_selection import train_test_split
from sklearn.linear_model import LogisticRegression
from sklearn.metrics import classification_report, roc_auc_score
from sklearn.preprocessing import StandardScaler
from sklearn.pipeline import Pipeline

from 00_config import CFG

INFILE = os.path.join(CFG.out_dir, "per_hospital_risk_score.csv")

def main() -> None:
    if not os.path.exists(INFILE):
        raise FileNotFoundError(f"Missing {INFILE}. Run 01_pull_from_bigquery.py first.")

    os.makedirs(CFG.out_dir, exist_ok=True)
    df = pd.read_csv(INFILE)

    # Target: high risk if avg_excess_ratio > 1
    df["avg_excess_ratio"] = pd.to_numeric(df["avg_excess_ratio"], errors="coerce")
    df = df[df["avg_excess_ratio"].notna()].copy()
    df["high_risk"] = (df["avg_excess_ratio"] > 1.0).astype(int)

    # Features
    df["overall_rating"] = pd.to_numeric(df["overall_rating"], errors="coerce")
    df["measures_reported"] = pd.to_numeric(df["measures_reported"], errors="coerce")

    df["overall_rating"] = df["overall_rating"].fillna(df["overall_rating"].median())
    df["measures_reported"] = df["measures_reported"].fillna(df["measures_reported"].median())

    # Categorical fields
    cat_cols = ["hospital_type", "hospital_ownership", "emergency_services", "state"]
    for c in cat_cols:
        df[c] = df[c].fillna("Unknown")

    X = pd.get_dummies(
        df[["overall_rating", "measures_reported"] + cat_cols],
        drop_first=True
    )
    y = df["high_risk"]

    X_train, X_test, y_train, y_test = train_test_split(
        X, y, test_size=0.25, random_state=42, stratify=y
    )

    # Logistic regression with scaling (works well when numeric mixed with one-hot)
    model = Pipeline(steps=[
        ("scaler", StandardScaler(with_mean=False)),  # sparse-safe
        ("clf", LogisticRegression(max_iter=2000))
    ])

    model.fit(X_train, y_train)
    pred = model.predict(X_test)
    proba = model.predict_proba(X_test)[:, 1]

    report = classification_report(y_test, pred, digits=4)
    auc = roc_auc_score(y_test, proba)

    out_report = os.path.join(CFG.out_dir, "classification_report.txt")
    with open(out_report, "w", encoding="utf-8") as f:
        f.write(report)
        f.write(f"\nROC AUC: {auc:.4f}\n")

    print(report)
    print(f"ROC AUC: {auc:.4f}")
    print("Saved:", out_report)

    # Feature importance (logistic coefficients)
    clf = model.named_steps["clf"]
    coefs = pd.Series(clf.coef_[0], index=X.columns).sort_values(key=np.abs, ascending=False)
    coefs_path = os.path.join(CFG.out_dir, "logreg_feature_importance.csv")
    coefs.to_csv(coefs_path, header=["coef"])
    print("Saved:", coefs_path)

if __name__ == "__main__":
    main()

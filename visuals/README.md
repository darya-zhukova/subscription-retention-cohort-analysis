# Cohort Retention Visual

This folder contains the final visualization for the weekly subscription retention analysis.

## File

* `weekly_retention_cohort_analysis.png` — cohort retention table, heatmap, selected cohort retention curves, and weighted average retention chart

## What the Visual Shows

The visualization includes:

* weekly customer cohorts
* cohort size
* retention from Week 0 through Week 6
* a heatmap for comparing stronger and weaker cohorts
* selected cohort retention curves
* weighted average retention by week
* churn as the inverse of retention

## Key Takeaway

Retention declines most sharply during the first two weeks after subscription and then begins to stabilize.

Several December cohorts performed better than earlier November cohorts, suggesting that seasonality, acquisition quality, onboarding, or product changes may have influenced retention.

## Notes

Recent cohorts have incomplete observation periods, so unavailable weeks are left blank rather than shown as zero.

The visualization was created in Google Sheets using results generated with BigQuery SQL.


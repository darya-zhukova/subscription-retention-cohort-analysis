# SQL Analysis

This folder contains the BigQuery SQL used to create weekly subscription cohorts and calculate retention from Week 0 through Week 6.

## File

* `weekly_retention_cohort_analysis.sql` — assigns customers to weekly cohorts, calculates cohort size, tracks active subscribers by week, and produces the retention matrix used in the final visualization

## SQL Logic

The query includes the following steps:

1. Defines the available analysis period
2. Assigns each subscriber to a Monday-based cohort week
3. Calculates the number of weeks between subscription and cancellation
4. Determines whether each customer remained active during Week 0 through Week 6
5. Aggregates results by cohort
6. Calculates weekly retention rates
7. Leaves unavailable weeks blank for recent cohorts

## Notes

Cohorts are based on Monday–Sunday calendar weeks.

Because November 1, 2020 was a Sunday, subscriptions from that date were assigned to the cohort week beginning October 26, 2020.

Recent cohorts do not have enough observation time for all retention weeks. These values were left blank rather than treated as zero.

The original BigQuery project and dataset names were replaced with generic placeholders for the public portfolio version.

The source dataset is not included in this repository.


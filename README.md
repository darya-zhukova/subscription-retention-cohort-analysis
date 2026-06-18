# Subscription Retention Cohort Analysis

## Project Overview

This project analyzes weekly subscription retention across customer cohorts.

The goal was to understand how retention changes during the first several weeks after subscription and whether some cohorts perform better than others.

Customers were grouped by the week in which they started their subscription. Retention was then tracked from **Week 0 through Week 6**.

The analysis was completed using **BigQuery SQL** and presented as a cohort retention table, heatmap, and supporting charts.

---

## Business Questions

The analysis focused on the following questions:

* How quickly does retention decline after the subscription week?
* During which weeks does the largest customer loss occur?
* Which cohorts have stronger or weaker retention?
* Do newer cohorts retain better than earlier cohorts?
* What should the business investigate to improve long-term retention?

---

## Dataset

The dataset contains subscription records with customer subscription and cancellation dates.

The available data covers:

**November 1, 2020 to January 31, 2021**

Cohorts were assigned using Monday-based calendar weeks.

Because November 1, 2020 was a Sunday, customers who subscribed on that date were assigned to the cohort week beginning **October 26, 2020**.

The original dataset is not included in this repository.

---

## Cohort Methodology

Each customer was assigned to a cohort based on the week their subscription started.

Retention was calculated as the percentage of the original cohort that remained subscribed during each following week.

* **Week 0** represents the subscription week
* **Week 1** represents the first full week after subscription
* **Week 2** represents the second week after subscription
* Retention was tracked through **Week 6**

Recent cohorts do not have complete data for later weeks. These values were left blank rather than treated as zero.

This prevents incomplete cohorts from incorrectly lowering the retention results.

---

## Tools Used

* BigQuery
* SQL
* Google Sheets
* Cohort analysis
* Retention analysis
* Data visualization

---

## Key Results

The weighted average retention rates were:

| Period | Weighted Retention |
| ------ | -----------------: |
| Week 0 |            100.00% |
| Week 1 |             95.37% |
| Week 2 |             92.03% |
| Week 3 |             90.85% |
| Week 4 |             89.99% |
| Week 5 |             89.22% |
| Week 6 |             88.51% |

By Week 6, approximately **88.5%** of subscribers remained active, while approximately **11.5%** had churned.

---

## Key Findings

### Retention declines most during the first two weeks

The largest decline happened immediately after the subscription week.

Retention fell:

* **4.63 percentage points** between Week 0 and Week 1
* another **3.34 percentage points** between Week 1 and Week 2

After Week 2, the rate of decline became much smaller.

This suggests that the earliest stage of the customer lifecycle is the most important period for retention activity.

### Retention stabilizes after the early drop

After the first two weeks, retention continued to decrease, but at a slower rate.

The weighted retention rate changed from:

* **92.03% in Week 2**
* to **88.51% in Week 6**

This indicates that customers who remain subscribed through the early weeks are more likely to continue.

### December cohorts performed better

Several December cohorts showed stronger retention than the earlier November cohorts.

For example:

* the December 21 cohort retained approximately **93.24%** of customers by Week 6
* the November 2 cohort retained approximately **84.57%** by Week 6

This difference may be connected to seasonality, acquisition source, customer quality, product changes, promotions, or onboarding improvements.

Additional analysis would be required to determine the reason.

### Recent cohorts have incomplete observation periods

January cohorts appear only in the first few retention weeks because the available dataset ends on January 31, 2021.

These cohorts should not be compared directly with older cohorts at Week 4, Week 5, or Week 6 because they had not yet reached those stages.

---

## Business Insights

### Early retention should be the main priority

Most churn occurs during the first two weeks.

The business should focus on the early customer experience, including:

* onboarding
* first-use guidance
* product education
* customer support
* early engagement reminders
* communication of product value

### Stronger cohorts should be investigated

The better performance of several December cohorts may provide useful information.

The business should compare stronger and weaker cohorts across:

* acquisition channels
* campaigns
* subscription plans
* customer segments
* onboarding experience
* product changes
* seasonal behavior

### Cohort-level averages can hide important differences

The weighted average gives a useful overall retention benchmark, but individual cohorts show meaningful variation.

Retention should therefore be monitored both:

* as an overall KPI
* and separately by cohort and customer segment

---

## Recommended Actions

### Improve the first two weeks

Possible actions include:

* creating a structured onboarding journey
* sending timely product tips
* checking whether customers complete important setup steps
* identifying users with low early engagement
* offering proactive customer support
* asking for early feedback

### Create an early-warning retention system

Customers showing low engagement during the first week could receive targeted support before they churn.

Useful signals may include:

* no product activity
* incomplete setup
* low feature usage
* unanswered onboarding communication
* early cancellation attempts

### Compare high- and low-performing cohorts

Investigate what changed between November and December cohorts.

This may reveal successful campaigns, customer segments, or product experiences that can be repeated.

---

## Next Steps

Further analysis could include:

* retention by acquisition channel
* retention by subscription plan
* retention by customer segment
* monthly and longer-term retention
* customer lifetime value by cohort
* reasons for cancellation
* onboarding completion and feature usage
* statistical comparison of cohort performance

---

## Project Files

* [`sql/weekly_retention_cohort_analysis.sql`](sql/weekly_retention_cohort_analysis.sql) — BigQuery SQL used to create cohorts and calculate weekly retention
* [`visuals/weekly_retention_cohort_analysis.png`](visuals/weekly_retention_cohort_analysis.png) — cohort retention table, heatmap, and supporting charts

---

## Notes

The BigQuery project and dataset names were anonymized for this public portfolio.

Incomplete retention periods were left blank to avoid treating unavailable observations as churn.

The analysis is based on the available subscription period and should not be interpreted as a complete long-term retention study.

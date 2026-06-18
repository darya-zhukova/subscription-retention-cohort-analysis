-- BigQuery SQL
-- Weekly subscription retention cohort analysis
-- Table names were anonymized for this public portfolio.

DECLARE window_end, window_start DATE;                       
SET window_end = '2021-02-01';  
SET window_start = '2020-11-01';

WITH user_activity AS (
  SELECT DISTINCT 
    user_pseudo_id, 
    category,
    subscription_start, 
    subscription_end
  FROM `your_project.your_dataset.subscriptions`
  WHERE subscription_start >= window_start AND subscription_start < window_end
),

cohort_users AS (
  -- Cohort = Monday of the user's first start week (per user+category)
  SELECT *,
    MIN(DATE_TRUNC(DATE(subscription_start), WEEK(MONDAY))) 
      OVER (PARTITION BY user_pseudo_id, category ORDER BY subscription_start) AS cohort_user,
      -- Unsubscribe week (Monday), NULL if still active
    DATE_TRUNC(DATE(subscription_end), WEEK(MONDAY)) AS unsub_week
  FROM user_activity
),

unsub_week AS (
  -- Offset of unsubscribe week from cohort week (0..6) 
  SELECT *,
    CASE WHEN unsub_week IS NULL THEN NULL
         ELSE DATE_DIFF(unsub_week, cohort_user, WEEK)
    END AS unsub_week_user,
    -- stable composite key
    CONCAT(CAST(user_pseudo_id AS STRING), '#', IFNULL(category,'')) AS entity_key
  FROM cohort_users
),

churned_users AS (
  -- Cumulative churn counts (≤ k) by DISTINCT (user,category) entities
  SELECT 
    cohort_user,
    COUNT(DISTINCT entity_key) AS cohort_size,
    COUNT(DISTINCT IF(unsub_week_user = 0, entity_key, NULL)) AS week_0,
    COUNT(DISTINCT IF(unsub_week_user <= 1, entity_key, NULL)) AS week_1,
    COUNT(DISTINCT IF(unsub_week_user <= 2, entity_key, NULL)) AS week_2,
    COUNT(DISTINCT IF(unsub_week_user <= 3, entity_key, NULL)) AS week_3,
    COUNT(DISTINCT IF(unsub_week_user <= 4, entity_key, NULL)) AS week_4,
    COUNT(DISTINCT IF(unsub_week_user <= 5, entity_key, NULL)) AS week_5,
    COUNT(DISTINCT IF(unsub_week_user <= 6, entity_key, NULL)) AS week_6
  FROM unsub_week
  GROUP BY cohort_user
)

-- Retention % = 1 - (cum_churn / cohort_size)
SELECT 
  cohort_user,
  cohort_size,

  -- show only if the FULL week has passed: cohort + (k+1) weeks - 1 day <= max_data_date
      1.00 AS week0,
  CASE WHEN DATE_ADD(cohort_user, INTERVAL 1 WEEK) - 1 < window_end
       THEN ROUND((1 - SAFE_DIVIDE(week_0, cohort_size)), 4) END AS week1,
  CASE WHEN DATE_ADD(cohort_user, INTERVAL 2 WEEK) - 1 < window_end
       THEN ROUND((1 - SAFE_DIVIDE(week_1, cohort_size)), 4) END AS week2,
  CASE WHEN DATE_ADD(cohort_user, INTERVAL 3 WEEK) - 1 < window_end
       THEN ROUND((1 - SAFE_DIVIDE(week_2, cohort_size)), 4) END AS week3,
  CASE WHEN DATE_ADD(cohort_user, INTERVAL 4 WEEK) - 1 < window_end
       THEN ROUND((1 - SAFE_DIVIDE(week_3, cohort_size)), 4) END AS week4,
  CASE WHEN DATE_ADD(cohort_user, INTERVAL 5 WEEK) - 1 < window_end
       THEN ROUND((1 - SAFE_DIVIDE(week_4, cohort_size)), 4) END AS week5,
  CASE WHEN DATE_ADD(cohort_user, INTERVAL 6 WEEK) - 1 < window_end
       THEN ROUND((1 - SAFE_DIVIDE(week_5, cohort_size)), 4) END AS week6

FROM churned_users
ORDER BY cohort_user;

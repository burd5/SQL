-- https://datalemur.com/questions/user-retention

-- Active User Retention

-- Write a query to obtain number of monthly active users (MAUs) 
-- in July 2022, including the month in numerical format "1, 2, 3".

with active_month_counts as (
  SELECT
    user_id,
    SUM(CASE WHEN DATE_PART('month', event_date) = 6 THEN 1 ELSE 0 END) as june_count,
    SUM(CASE WHEN DATE_PART('month', event_date) = 7 THEN 1 ELSE 0 END) as july_count
  FROM user_actions
  WHERE event_type is not NULL AND DATE_PART('year', event_date) = 2022
  GROUP BY user_id
)

select
  7 as month,
  COUNT(user_id) as monthly_active_users
from active_month_counts
where june_count > 0 and july_count > 0
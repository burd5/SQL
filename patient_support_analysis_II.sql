-- https://datalemur.com/questions/uncategorized-calls-percentage

-- Patient Support Analysis (Part 2)

SELECT
  ROUND( SUM(CASE WHEN call_category = 'n/a' or call_category is NULL THEN 1 ELSE 0 END * 100.0) /
  COUNT(*), 1) as uncategorised_call_pct
FROM callers;

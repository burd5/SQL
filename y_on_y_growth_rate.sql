-- https://datalemur.com/questions/yoy-growth-rate

-- Y on Y Growth Rate

-- Write a query to calculate the year-on-year growth rate 
-- for the total spend of each product, grouping the results by product ID.
-- output should include the year in ascending order, product ID, current year's spend, previous year's spend 
-- and year-on-year growth percentage, rounded to 2 decimal places.

with year_over_year as (
  SELECT
    EXTRACT('year' from transaction_date) as year,
    product_id,
    spend as curr_year_spend,
    LAG(spend, 1) over(partition by product_id order by EXTRACT('year' from transaction_date)) as prev_year_spend
  FROM user_transactions
  )

select
  year,
  product_id,
  curr_year_spend,
  prev_year_spend,
  ROUND( (curr_year_spend - prev_year_spend) * 100.0  / prev_year_spend, 2) as yoy_rate
from year_over_year

-- provided solution

WITH yearly_spend_cte AS (
  SELECT 
    EXTRACT(YEAR FROM transaction_date) AS yr,
    product_id,
    spend AS curr_year_spend,
    LAG(spend) OVER (
      PARTITION BY product_id 
      ORDER BY 
        product_id, 
        EXTRACT(YEAR FROM transaction_date)) AS prev_year_spend 
  FROM user_transactions
)

SELECT 
  yr,
  product_id, 
  curr_year_spend, 
  prev_year_spend, 
  ROUND(100 * 
    (curr_year_spend - prev_year_spend)
    / prev_year_spend
  , 2) AS yoy_rate 
FROM yearly_spend_cte;
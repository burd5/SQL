-- https://datalemur.com/questions/sql-bloomberg-stock-inter-month-percentage-2

-- FAANG Stock Inter-Month Change (Part 2) [Bloomberg SQL Interview Question]

with lag_prices as (
  SELECT ticker,
         date,
         close,
         lag(close, 1, NULL) over(partition by ticker order by ticker, date asc) as previous_month_price
  FROM stock_prices
)

select ticker,
      date,
      close,
      ROUND( (close - previous_month_price) / previous_month_price * 100, 2) as intermth_change_pct
from lag_prices

--------
-- https://datalemur.com/questions/sql-bloomberg-stock-min-max-1

-- FAANG Stock Min Max

-- MY SOLUTION

-- ticker, highest_mth, highest_open, lowest_mth, lowest_open
-- sorted by ticker symbol

with highest_prices as (
  SELECT
    ticker,
    MAX(open) as highest_open,
    TO_CHAR(date, 'Mon-YYYY') AS highest_mth,
    ROW_NUMBER() OVER(partition by ticker order by open desc) as row_num
  FROM stock_prices
  GROUP BY ticker, open, date
  ORDER BY ticker
),

lowest_prices as (
  SELECT
    ticker,
    MIN(open) as lowest_open,
    TO_CHAR(date, 'Mon-YYYY') AS lowest_mth,
    ROW_NUMBER() OVER(partition by ticker order by open) as row_num
  FROM stock_prices
  GROUP BY ticker, open, date
  ORDER BY ticker
)

select
  hp.ticker,
  highest_mth,
  highest_open,
  lowest_mth,
  lowest_open
from highest_prices hp join lowest_prices lp on hp.ticker = lp.ticker
  AND hp.row_num = 1
  AND lp.row_num = 1
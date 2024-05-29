-- https://datalemur.com/questions/median-search-freq

-- Median Google Search Frequency

-- PROVIDED SOLUTION

-- the median number of searches a person made last year.
-- output -> median (round to one decimal point)

-- 1, 1, 2, 2, 3, 3, 3, 4
-- output = 2.5

WITH searches_expanded AS (
  SELECT searches
  FROM search_frequency
  GROUP BY 
    searches, 
    GENERATE_SERIES(1, num_users))

SELECT 
  ROUND(PERCENTILE_CONT(0.50) WITHIN GROUP (
    ORDER BY searches)::DECIMAL, 1) AS  median
FROM searches_expanded;


-- Pharmacy Analytics (Part 1)

/*

https://datalemur.com/questions/top-profitable-drugs

*/

-- My Solution

SELECT drug, (total_sales - cogs) as total_profit
FROM pharmacy_sales
ORDER BY 2 DESC
LIMIT 3;



-- 2nd Attempt

-- top 3 most profitable drugs
-- how much profit
-- profit DESC

-- UNNECCESSARY TO GROUP BY HERE

SELECT
  drug,
  SUM(total_sales - cogs) as total_profit -- don't need sum either
FROM pharmacy_sales
-- GROUP BY drug
ORDER BY total_profit DESC
LIMIT 3;
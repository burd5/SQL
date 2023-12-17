-- Pharmacy Analytics (Part 1)

/*

https://datalemur.com/questions/top-profitable-drugs

*/

-- My Solution

SELECT drug, (total_sales - cogs) as total_profit
FROM pharmacy_sales
ORDER BY 2 DESC
LIMIT 3;




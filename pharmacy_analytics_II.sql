-- Pharmacy Analytics II

/*

https://datalemur.com/questions/non-profitable-drugs

*/

-- My Solution

SELECT manufacturer, count(drug) as drug_count, ABS(SUM(total_sales) - SUM(cogs)) as total_loss
FROM pharmacy_sales
WHERE total_sales < cogs
GROUP BY manufacturer
ORDER BY 3 DESC;

-- Provided Solutions

SELECT
  manufacturer,
  COUNT(drug) AS drug_count,
  ABS(SUM(total_sales - cogs)) AS total_loss
FROM pharmacy_sales
WHERE total_sales - cogs <= 0
GROUP BY manufacturer
ORDER BY total_loss DESC;

SELECT
  manufacturer,
  COUNT(drug) AS drug_count, 
  SUM(cogs - total_sales) AS total_loss
FROM pharmacy_sales
WHERE cogs > total_sales
GROUP BY manufacturer
ORDER BY total_loss DESC;
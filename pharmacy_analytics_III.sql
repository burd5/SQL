-- Pharmacy Analytics III

/*

https://datalemur.com/questions/total-drugs-sales

*/

-- My Solution

SELECT manufacturer, CONCAT('$', ROUND(SUM(total_sales)/1000000.0, 0)::text,' million') as sales_mil
FROM pharmacy_sales
GROUP BY manufacturer
ORDER BY ROUND(SUM(total_sales)/1000000.0, 0) DESC, 1 DESC;

-- Provided Solutions

SELECT 
  manufacturer, 
  CONCAT( '$', ROUND(SUM(total_sales) / 1000000), ' million') AS sales_mil 
FROM pharmacy_sales 
GROUP BY manufacturer 
ORDER BY SUM(total_sales) DESC, manufacturer;

WITH drug_sales AS (
  SELECT 
    manufacturer, 
    SUM(total_sales) as sales 
  FROM pharmacy_sales 
  GROUP BY manufacturer
) 

SELECT 
  manufacturer, 
  ('$' || ROUND(sales / 1000000) || ' million') AS sales_mil 
FROM drug_sales 
ORDER BY sales DESC, manufacturer;
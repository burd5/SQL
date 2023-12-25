-- Highest Grossing Items

/*

https://datalemur.com/questions/sql-highest-grossing

*/

-- My Solution

SELECT category, product, total_spend
FROM (
  select category, product, SUM(spend) as total_spend, ROW_NUMBER() OVER(partition by category order by SUM(spend) desc) as product_rank
  from product_spend
  where EXTRACT(year from transaction_date) = 2022
  group by 1,2
) r
where product_rank <= 2

-- Provided Solutions

SELECT 
  category, 
  product, 
  total_spend 
FROM (
  SELECT 
    category, 
    product, 
    SUM(spend) AS total_spend,
    RANK() OVER (
      PARTITION BY category 
      ORDER BY SUM(spend) DESC) AS ranking 
  FROM product_spend
  WHERE EXTRACT(YEAR FROM transaction_date) = 2022
  GROUP BY category, product
) AS ranked_spending
WHERE ranking <= 2 
ORDER BY category, ranking;


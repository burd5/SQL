-- Histogram of Users and Purchases

/*

https://datalemur.com/questions/histogram-users-purchases

*/

-- My Solution

SELECT transaction_date, user_id, count(product_id) as purchase_count
FROM user_transactions
WHERE transaction_date in (select max(transaction_date)
                          from user_transactions
                          group by user_id)
GROUP BY 2,1
ORDER BY 1 ASC;

-- Provided Solution

WITH latest_transactions_cte AS (
  SELECT 
    transaction_date, 
    user_id, 
    product_id, 
    RANK() OVER (
      PARTITION BY user_id 
      ORDER BY transaction_date DESC) AS transaction_rank 
  FROM user_transactions) 
  
SELECT 
  transaction_date, 
  user_id,
  COUNT(product_id) AS purchase_count
FROM latest_transactions_cte
WHERE transaction_rank = 1 
GROUP BY transaction_date, user_id
ORDER BY transaction_date;

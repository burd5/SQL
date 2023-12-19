-- Users Third Transaction

/*

https://datalemur.com/questions/sql-third-transaction

*/

-- My Solution

SELECT user_id, spend, transaction_date
FROM (
  SELECT *, row_number() OVER(PARTITION BY user_id ORDER BY transaction_date ASC) AS row
  FROM transactions
) t
WHERE row = 3

-- Provided Solutions

SELECT 
  user_id,
  spend,
  transaction_date
FROM (
  SELECT 
    user_id, 
    spend, 
    transaction_date, 
    ROW_NUMBER() OVER (
      PARTITION BY user_id ORDER BY transaction_date) AS row_num
  FROM transactions) AS trans_num 
WHERE row_num = 3;

---------------------

WITH trans_num AS (
  SELECT 
    user_id, 
    spend, 
    transaction_date, 
    ROW_NUMBER() OVER (
      PARTITION BY user_id ORDER BY transaction_date) AS row_num 
  FROM transactions)
 
SELECT 
  user_id, 
  spend, 
  transaction_date 
FROM trans_num 
WHERE row_num = 3;
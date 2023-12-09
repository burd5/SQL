-- Cities With Completed Trades

-- https://datalemur.com/questions/completed-trades

-- My Solution

SELECT u.city , count(*) as total_orders
FROM trades t join users u using(user_id)
WHERE status = 'Completed'
GROUP BY city
ORDER BY 2 DESC
LIMIT 3;

-- Other Solution

SELECT 
  users.city, 
  COUNT(trades.order_id) AS total_orders 
FROM trades 
INNER JOIN users 
  ON trades.user_id = users.user_id 
WHERE trades.status = 'Completed' 
GROUP BY users.city 
ORDER BY total_orders DESC
LIMIT 3;
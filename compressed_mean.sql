-- Compressed Mean

/*

https://datalemur.com/questions/alibaba-compressed-mean


*/

-- My Solution

SELECT ROUND( (SUM(item_count * order_occurrences)/SUM(order_occurrences))::numeric, 1) as mean
FROM items_per_order;

-- Other Solutions

SELECT 
  SUM(item_count::DECIMAL*order_occurrences)
    /SUM(order_occurrences) AS mean
FROM items_per_order;

SELECT 
  ROUND(
    SUM(item_count::DECIMAL*order_occurrences)
    /SUM(order_occurrences)
  ,1) AS mean
FROM items_per_order;

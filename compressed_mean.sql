-- Compressed Mean

/*

https://datalemur.com/questions/alibaba-compressed-mean


*/

-- My Solution

SELECT ROUND( (SUM(item_count * order_occurrences)/SUM(order_occurrences))::numeric, 1) as mean
FROM items_per_order;

-- Other Solutions

/*

However, it's important to note that both item_count and order_occurrences are of integer type by default, which means that division will return an integer result. To ensure that the output is rounded to 1 decimal place, we can cast either column to a decimal type using ::DECIMAL or CAST(field AS decimal).

*/

SELECT 
  SUM(item_count::DECIMAL*order_occurrences)
    /SUM(order_occurrences) AS mean
FROM items_per_order;

SELECT 
  ROUND(
    SUM(item_count::DECIMAL*order_occurrences)
    /SUM(order_occurrences)
  ,1) AS mean
FROM items_per_order;+

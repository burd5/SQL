-- Compressed Mode

/*
https://datalemur.com/questions/alibaba-compressed-mode
*/

-- My Solution

select item_count
from items_per_order
where order_occurrences = 
  (SELECT MAX(order_occurrences)
  FROM items_per_order)
order by 1 


-- Solution Using Mode

SELECT item_count AS mode
FROM items_per_order
WHERE order_occurrences = (
  SELECT MODE() WITHIN GROUP (ORDER BY order_occurrences DESC) 
  FROM items_per_order
)
ORDER BY item_count;

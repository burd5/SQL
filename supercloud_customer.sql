-- Supercloud Customer

/*

https://datalemur.com/questions/supercloud-customer

*/


-- Solution

with supercloud as (
  SELECT cc.customer_id,
         COUNT(DISTINCT p.product_category) as unique_count
  FROM customer_contracts cc left join products p
       on cc.product_id = p.product_id
  GROUP BY cc.customer_id
)

select customer_id
from supercloud
where unique_count = (
  select count(distinct product_category)
  from products
  )
order by customer_id;
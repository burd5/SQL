-- Insights for Online Store Product Variants

/*

You are provided with a table named product_variants in an online store's database. This table tracks different color and size variants of products along with their stock status. Your task is to write an SQL query that computes the total number of unique product variants and the number of in-stock variants for each product in an online store's inventory.

product_variants:

id (int): Primary key
product_id (int): Identifier for the product.
color_id (int): Identifier for a specific color variant of the product.
size_id (int): Identifier for a specific size variant of the product.
in_stock (boolean): Indicates whether the variant is in stock (true for in stock, false for out of stock).
Calculate the total number of unique variants for each product. A unique variant is defined by a unique combination of color_id and size_id. Calculate also the number of variants that are currently in stock for each product.

The output should have the following columns:

product_id: The identifier for the product.
total_unique_variants: The total number of unique variants of the product.
in_stock_variants: The number of variants that are currently in stock.
The result should be sorted by product_id in ascending order.


*/


-- Solution

SELECT 
  product_id, 
  COUNT(product_id) AS total_unique_variants, 
  COUNT(CASE in_stock WHEN true THEN 1 ELSE null END) AS in_stock_variants 
FROM product_variants 
  GROUP BY product_id 
  ORDER BY product_id ASC;

select product_id, count(distinct(color_id, size_id)) as total_unique_variants, count(distinct(color_id, size_id)) filter (where in_stock) as in_stock_variants from product_variants p
group by 1
order by 1
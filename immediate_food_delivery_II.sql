-- Immediate Food Delivery II

/*

Table: Delivery

+-----------------------------+---------+
| Column Name                 | Type    |
+-----------------------------+---------+
| delivery_id                 | int     |
| customer_id                 | int     |
| order_date                  | date    |
| customer_pref_delivery_date | date    |
+-----------------------------+---------+
delivery_id is the column of unique values of this table.
The table holds information about food delivery to customers that make orders at some date and specify a preferred delivery date (on the same order date or after it).
 

If the customer's preferred delivery date is the same as the order date, then the order is called immediate; otherwise, it is called scheduled.

The first order of a customer is the order with the earliest order date that the customer made. It is guaranteed that a customer has precisely one first order.

Write a solution to find the percentage of immediate orders in the first orders of all customers, rounded to 2 decimal places.

The result format is in the following example.

 

Example 1:

Input: 
Delivery table:
+-------------+-------------+------------+-----------------------------+
| delivery_id | customer_id | order_date | customer_pref_delivery_date |
+-------------+-------------+------------+-----------------------------+
| 1           | 1           | 2019-08-01 | 2019-08-02                  |
| 2           | 2           | 2019-08-02 | 2019-08-02                  |
| 3           | 1           | 2019-08-11 | 2019-08-12                  |
| 4           | 3           | 2019-08-24 | 2019-08-24                  |
| 5           | 3           | 2019-08-21 | 2019-08-22                  |
| 6           | 2           | 2019-08-11 | 2019-08-13                  |
| 7           | 4           | 2019-08-09 | 2019-08-09                  |
+-------------+-------------+------------+-----------------------------+
Output: 
+----------------------+
| immediate_percentage |
+----------------------+
| 50.00                |
+----------------------+

*/

select ROUND(AVG(order_date = customer_pref_delivery_date) * 100, 2) as immediate_percentage
from delivery where (customer_id, order_date) IN
(select customer_id, min(order_date) as first_order
from delivery
group by customer_id)

-----

select round(sum(if(order_date = customer_pref_delivery_date, 1, 0)) / count(*) * 100, 2) as immediate_percentage from Delivery
where (customer_id, order_date) in
(
    Select customer_id, min(order_date) from Delivery group by customer_id
)

-- 2nd attempt

with first_orders as (
    select customer_id, min(order_date) as first_order
    from delivery
    group by customer_id
)

select ROUND(SUM(CASE WHEN first_order = customer_pref_delivery_date THEN 1 ELSE 0 END)/
        CAST(count(distinct customer_id) as numeric) * 100, 2) as immediate_percentage
from first_orders
join delivery using(customer_id)

-- 2nd attempt subquery

select ROUND(SUM(CASE WHEN order_date = customer_pref_delivery_date THEN 1 ELSE 0 END)/
        CAST(count(distinct customer_id) as numeric) * 100, 2) as immediate_percentage
from delivery
where (customer_id, order_date) in
    (select customer_id, min(order_date)
    from delivery
    group by customer_id)
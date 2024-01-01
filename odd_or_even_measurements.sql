-- Odd and Even Measurements

/*

https://datalemur.com/questions/odd-even-measurements

*/


-- My Solution

with row_order as(
  SELECT measurement_time, measurement_value,
  row_number() over(partition by extract(day from measurement_time) order by extract(hour from measurement_time)) as row_num
  FROM measurements
)

select DATE(measurement_time),
       sum(case when row_num % 2 = 1 then measurement_value else 0 end) as odd_sum,
       sum(case when row_num % 2 = 0 then measurement_value else 0 end) as even_sum
from row_order
group by 1
order by 1

-- Other Solutions

WITH ranked_measurements AS (
  SELECT 
    measurement_time::date AS measurement_day, 
    measurement_value, 
    ROW_NUMBER() OVER (
      PARTITION BY measurement_time::date
      ORDER BY measurement_time) AS measurement_num 
  FROM measurements
) 

SELECT 
  measurement_day, 
  SUM(measurement_value) FILTER (WHERE measurement_num % 2 != 0) AS odd_sum, 
  SUM(measurement_value) FILTER (WHERE measurement_num % 2 = 0) AS even_sum 
FROM ranked_measurements
GROUP BY measurement_day;

-- Average Review Ratings

/*
https://datalemur.com/questions/sql-avg-review-ratings
*/

-- My Solution

SELECT DATE_PART('month',submit_date), product_id, ROUND(AVG(stars), 2) as avg_stars
FROM reviews
GROUP BY 1,2
ORDER BY 1,2;

-- Other Solutions

SELECT 
  EXTRACT(MONTH FROM submit_date) AS mth,
  product_id,
  ROUND(AVG(stars), 2) AS avg_stars
FROM reviews
GROUP BY 
  EXTRACT(MONTH FROM submit_date), 
  product_id
ORDER BY mth, product_id;
-- Average Post Hiatus

/*

https://datalemur.com/questions/sql-average-post-hiatus-1

Given a table of Facebook posts, for each user who posted at least twice in 2021, write a query to find the number of days between each user’s first post of the year and last post of the year in the year 2021. Output the user and number of the days between each user's first and last post.

*/

-- My Solution

SELECT user_id, DATE_PART('day', max(post_date) - min(post_date)) as days_between
FROM posts
WHERE extract(year from post_date) = 2021
GROUP BY user_id
HAVING count(user_id) > 1;

-- Other Similar Solution

SELECT 
	user_id, 
    MAX(post_date::DATE) - MIN(post_date::DATE) AS days_between
FROM posts
WHERE DATE_PART('year', post_date::DATE) = 2021 
GROUP BY user_id
HAVING COUNT(post_id)>1;

-- 2nd solution

select
  user_id,
  max(post_date::date) - min(post_date::date) as days_between
from posts
where date_part('year', post_date) = 2021
group by user_id
having count(user_id) > 1



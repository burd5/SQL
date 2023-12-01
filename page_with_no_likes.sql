-- Page With No Likes

/*

Assume you're given two tables containing data about Facebook Pages and their respective likes (as in "Like a Facebook Page").

Write a query to return the IDs of the Facebook pages that have zero likes. The output should be sorted in ascending order based on the page IDs.

*/

-- My Solution

SELECT p.page_id 
FROM pages p left join page_likes pl using(page_id)
WHERE liked_date IS NULL
ORDER BY 1 ASC

-- Other Solutions

SELECT page_id
FROM pages
EXCEPT
SELECT page_id
FROM page_likes;

SELECT page_id
FROM pages
WHERE page_id NOT IN (
  SELECT page_id
  FROM page_likes
  WHERE page_id IS NOT NULL
);

SELECT page_id
FROM pages
WHERE NOT EXISTS (
  SELECT page_id
  FROM page_likes AS likes
  WHERE likes.page_id = pages.page_id
;)


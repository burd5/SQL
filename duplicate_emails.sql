-- Duplicate Emails

/*



*/

-- My Solution

SELECT email
FROM Person
GROUP BY email
HAVING COUNT(*) > 1


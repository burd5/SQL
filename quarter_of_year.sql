-- # Quarter of the Year

/*

Given a month as an integer from 1 to 12, return to which quarter of the year it belongs as an integer number.

For example: month 2 (February), is part of the first quarter; month 6 (June), is part of the second quarter; and month 11 (November), is part of the fourth quarter.

*/

-- # My Solution

SELECT month,
CASE 
    WHEN month <= 3 THEN 1
    WHEN month <= 6 THEN 2
    WHEN month <= 9 THEN 3
    WHEN month <= 12 THEN 4
END AS res
FROM quarterof

-- # Other Solutions

SELECT month, (month + 2) / 3 AS res FROM quarterof;


SELECT month,
  CASE
    WHEN month BETWEEN 1 and 3 THEN 1
    WHEN month BETWEEN 4 and 6 THEN 2
    WHEN month BETWEEN 7 and 9 THEN 3
    WHEN month BETWEEN 10 and 12 THEN 4
    END AS res
FROM
  quarterof
WHERE  month BETWEEN 1 and 12
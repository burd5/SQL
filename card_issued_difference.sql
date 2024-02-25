-- Card Issued Difference

/*

https://datalemur.com/questions/cards-issued-difference

*/

-- My Solution

SELECT card_name, MAX(issued_amount) - MIN(issued_amount) as difference
FROM monthly_cards_issued
GROUP BY card_name
ORDER BY 2 desc;

-- 2nd attempt

SELECT
  card_name,
  MAX(issued_amount) - MIN(issued_amount) as difference
FROM monthly_cards_issued
GROUP BY card_name
ORDER BY 2 DESC
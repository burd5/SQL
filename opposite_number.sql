-- # Opposite Number

/*

Very simple, given an integer or a floating-point number, find its opposite.

Examples:

1: -1
14: -14
-34: 34
You will be given a table: opposite, with a column: number. Return a table with a column: res.

*/

-- # My Solution
SELECT 
CASE 
  WHEN number < 0 THEN abs(number)
  WHEN number > 0 THEN number * -1
  ELSE 0
END AS res
FROM opposite

-- # Better Solution

SELECT
  NUMBER * (-1) AS res
FROM OPPOSITE
-- # Remove First and Last Character

/*

It's pretty straightforward. Your goal is to create a function that removes the first and last characters of a string. You're given one parameter, the original string. You don't have to worry with strings with less than two characters.

*/

SELECT s,
  SUBSTRING(s, 2, LENGTH(s) - 2) AS res
FROM removechar

SELECT s, SUBSTRING(s, 2, LENGTH(s) - 2) AS res 
FROM removechar
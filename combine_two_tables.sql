-- Combine Two Tables

/*

Write a solution to report the first name, last name, city, and state of each person in the Person table. If the address of a personId is not present in the Address table, report null instead.

Return the result table in any order.

*/

-- Solution

SELECT P.firstName, P.lastName, A.city, A.state
FROM Person P LEFT JOIN Address A
on P.personId = A.personId

-- Unnecessary Solution

SELECT firstName, lastName, COALESCE(city, null) as city, COALESCE(state, null) as state
FROM Person p 
LEFT JOIN Address a ON p.personId = a.personId


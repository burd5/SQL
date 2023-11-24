-- Second Highest Salary

/*

Write a solution to find the second highest salary from the Employee table. If there is no second highest salary, return null (return None in Pandas).

*/

-- My Solution

SELECT MAX(salary) as SecondHighestSalary
FROM employee
WHERE salary <> (SELECT MAX(salary) FROM employee)

-- Other Solutions

SELECT
    (SELECT DISTINCT Salary 
    FROM Employee
    ORDER BY Salary DESC
    LIMIT 1 OFFSET 1) 
AS SecondHighestSalary;

-- 
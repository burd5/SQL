-- Nth Highest Salary

/*

Write a solution to find the nth highest salary from the Employee table. If there is no nth highest salary, return null.

*/

-- Solution

CREATE FUNCTION getNthHighestSalary(N INT) RETURNS INT
BEGIN
SET N = N-1;
RETURN (
SELECT DISTINCT(salary) from Employee order by salary DESC
      LIMIT 1 OFFSET N
);
END


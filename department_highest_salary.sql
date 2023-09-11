-- Department Highest Salary

/*

Table: Employee

+--------------+---------+
| Column Name  | Type    |
+--------------+---------+
| id           | int     |
| name         | varchar |
| salary       | int     |
| departmentId | int     |
+--------------+---------+
id is the primary key (column with unique values) for this table.
departmentId is a foreign key (reference columns) of the ID from the Department table.
Each row of this table indicates the ID, name, and salary of an employee. It also contains the ID of their department.
 

Table: Department

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| name        | varchar |
+-------------+---------+
id is the primary key (column with unique values) for this table. It is guaranteed that department name is not NULL.
Each row of this table indicates the ID of a department and its name.
 

Write a solution to find employees who have the highest salary in each of the departments.

Return the result table in any order.

The result format is in the following example.

Example 1:

Input: 
Employee table:
+----+-------+--------+--------------+
| id | name  | salary | departmentId |
+----+-------+--------+--------------+
| 1  | Joe   | 70000  | 1            |
| 2  | Jim   | 90000  | 1            |
| 3  | Henry | 80000  | 2            |
| 4  | Sam   | 60000  | 2            |
| 5  | Max   | 90000  | 1            |
+----+-------+--------+--------------+
Department table:
+----+-------+
| id | name  |
+----+-------+
| 1  | IT    |
| 2  | Sales |
+----+-------+
Output: 
+------------+----------+--------+
| Department | Employee | Salary |
+------------+----------+--------+
| IT         | Jim      | 90000  |
| Sales      | Henry    | 80000  |
| IT         | Max      | 90000  |
+------------+----------+--------+
Explanation: Max and Jim both have the highest salary in the IT department and Henry has the highest salary in the Sales department.

*/

-- Join Solution
SELECT Department.name AS Department ,Employee.name AS Employee, Employee.salary
FROM Department JOIN Employee ON Employee.departmentId=Department.id 
WHERE(departmentId, salary) IN
(SELECT departmentId,MAX(salary) FROM Employee GROUP BY departmentId);

-- Join Solution with MAX() partition
SELECT b.Name AS Department, a.Name AS Employee, Salary FROM
(SELECT *, MAX(Salary) OVER(PARTITION BY DepartmentId) AS max_val
FROM Employee) a
JOIN Department b
ON a.DepartmentId = b.Id
WHERE Salary = max_val;

-- Join Solution with RANK() partition
SELECT t1.Department, t1.Employee, t1.Salary
FROM(SELECT d.name AS Department, e.name AS Employee, e.salary AS Salary
,RANK()OVER(PARTITION BY d.id ORDER BY salary DESC) AS rk
FROM Department AS d
JOIN Employee AS e ON E.departmentId = d.id) AS t1
WHERE rk = 1

-- CTE solution with RANK() partition
WITH salaries_ranked AS (
    SELECT
        e.departmentId id,
        e.name name,
        e.salary salary,
        RANK() OVER(
            PARTITION BY e.departmentId
            ORDER BY e.salary DESC
        ) srank
    FROM Employee e
)
SELECT
    d.name Department,
    sr.name Employee,
    sr.salary
FROM salaries_ranked sr
JOIN Department d ON d.id = sr.id
WHERE sr.srank = 1;
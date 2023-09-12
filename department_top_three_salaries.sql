-- Department Top Three Salaries

/*

+--------------+---------+
| Column Name  | Type    |
+--------------+---------+
| id           | int     |
| name         | varchar |
| salary       | int     |
| departmentId | int     |
+--------------+---------+
id is the primary key (column with unique values) for this table.
departmentId is a foreign key (reference column) of the ID from the Department table.
Each row of this table indicates the ID, name, and salary of an employee. It also contains the ID of their department.
 

Table: Department

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| name        | varchar |
+-------------+---------+
id is the primary key (column with unique values) for this table.
Each row of this table indicates the ID of a department and its name.
 

A company's executives are interested in seeing who earns the most money in each of the company's departments. A high earner in a department is an employee who has a salary in the top three unique salaries for that department.

Write a solution to find the employees who are high earners in each of the departments.

Return the result table in any order.

The result format is in the following example.


Example 1:

Input: 
Employee table:
+----+-------+--------+--------------+
| id | name  | salary | departmentId |
+----+-------+--------+--------------+
| 1  | Joe   | 85000  | 1            |
| 2  | Henry | 80000  | 2            |
| 3  | Sam   | 60000  | 2            |
| 4  | Max   | 90000  | 1            |
| 5  | Janet | 69000  | 1            |
| 6  | Randy | 85000  | 1            |
| 7  | Will  | 70000  | 1            |
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
| IT         | Max      | 90000  |
| IT         | Joe      | 85000  |
| IT         | Randy    | 85000  |
| IT         | Will     | 70000  |
| Sales      | Henry    | 80000  |
| Sales      | Sam      | 60000  |
+------------+----------+--------+
Explanation: 
In the IT department:
- Max earns the highest unique salary
- Both Randy and Joe earn the second-highest unique salary
- Will earns the third-highest unique salary

In the Sales department:
- Henry earns the highest salary
- Sam earns the second-highest salary
- There is no third-highest salary as there are only two employees

*/

-- My Solution

WITH ranked_salary AS(
       SELECT salary, e.name as Employee, d.name as Department,
              DENSE_RANK() OVER(PARTITION BY d.name ORDER BY salary DESC) as Rank_Salary
              FROM employee e JOIN department d ON e.departmentid = d.id
)
SELECT Department, Employee, salary
FROM ranked_salary
WHERE Rank_Salary <= 3

-- Another dense rank answer

SELECT t.d_name AS Department
	,t.e_name AS Employee
	,t.Salary
FROM (
	SELECT e.name AS e_name
		,e.salary
		,d.Name AS d_name
		,DENSE_RANK() OVER (
			PARTITION BY departmentid ORDER BY salary DESC
			) AS row_num
	FROM employee AS e
	INNER JOIN department AS d ON e.departmentid = d.id
	) t
WHERE row_num <= 3

-- Other Solution

select d.name as department , e1.name as employee, e1.salary as Salary
from Employee e1 join Department d on e1.DepartmentId = d.Id
where  3 > (select count(distinct (e2.Salary))
        from  Employee e2
        where e2.Salary > e1.Salary
            and e1.DepartmentId = e2.DepartmentId)

            
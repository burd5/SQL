-- Calculate Special Bonus

/*

Table: Employees

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| employee_id | int     |
| name        | varchar |
| salary      | int     |
+-------------+---------+
employee_id is the primary key (column with unique values) for this table.
Each row of this table indicates the employee ID, employee name, and salary.
 

Write a solution to calculate the bonus of each employee. The bonus of an employee is 100% of their salary if the ID of the employee is an odd number and the employee's name does not start with the character 'M'. The bonus of an employee is 0 otherwise.

Return the result table ordered by employee_id.

The result format is in the following example.

Example 1:

Input: 
Employees table:
+-------------+---------+--------+
| employee_id | name    | salary |
+-------------+---------+--------+
| 2           | Meir    | 3000   |
| 3           | Michael | 3800   |
| 7           | Addilyn | 7400   |
| 8           | Juan    | 6100   |
| 9           | Kannon  | 7700   |
+-------------+---------+--------+
Output: 
+-------------+-------+
| employee_id | bonus |
+-------------+-------+
| 2           | 0     |
| 3           | 0     |
| 7           | 7400  |
| 8           | 0     |
| 9           | 7700  |
+-------------+-------+
Explanation: 
The employees with IDs 2 and 8 get 0 bonus because they have an even employee_id.
The employee with ID 3 gets 0 bonus because their name starts with 'M'.
The rest of the employees get a 100% bonus.

*/

-- My Solution

SELECT employee_id,
       CASE WHEN employee_id % 2 = 1 AND name NOT LIKE 'M%' THEN salary ELSE 0 END as bonus
FROM employees
ORDER BY employee_id

-- Union Solution

-- select entries with odd  employee id and name not start with M
select employee_id , salary as bonus 
from employees 
where employee_id%2 <>0 and name not like 'M%'

-- join both selection 
union

-- select remaining entries from table 
select employee_id , 0 as bonus
from employees
where employee_id%2 = 0 or name like 'M%'
order by employee_id;

-- Other Solution

select employee_id , salary * ( employee_id%2 ) * ( name not like 'M%') as bonus
from employees
order by employee_id;
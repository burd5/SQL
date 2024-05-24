-- https://datalemur.com/questions/sql-top-three-salaries

-- Top Three Salaries

-- MY SOLUTION --

-- dense rank 
-- top 3 salaries within each department
-- return name, dept name, salary
-- sort results by department id and salary desc, alphabetically

with department_ranks as (
  SELECT
      name,
      department_name,
      salary,
      dense_rank() over (partition by d.department_id order by salary desc) as salary_rank
  FROM employee e join department d on e.department_id = d.department_id
  ORDER BY d.department_id, salary desc, name
)

SELECT
    department_name,
    name,
    salary
FROM department_ranks
WHERE salary_rank <=3

-- PROVIDED SOLUTION --

WITH ranked_salary AS (
  SELECT 
    name,
    salary,
    department_id,
    DENSE_RANK() OVER (
      PARTITION BY department_id ORDER BY salary DESC) AS ranking
  FROM employee
)

SELECT 
  d.department_name,
  rs.name,
  rs.salary
FROM ranked_salary AS rs
INNER JOIN department AS d
  ON rs.department_id = d.department_id
WHERE rs.ranking <= 3
ORDER BY d.department_id, rs.salary DESC, rs.name ASC;
-- Unfinished Parts

/*

https://datalemur.com/questions/tesla-unfinished-parts

Tesla is investigating production bottlenecks and they need your help to extract the relevant data. Write a query to determine which parts have begun the assembly process but are not yet finished.

*/

-- My Solution

SELECT part, assembly_step
FROM parts_assembly
WHERE finish_date IS NULL;


-- Other Solutions

select part, assembly_step
from parts_assembly
where finish_date is null
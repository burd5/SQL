-- Duplicate Job Listings

/*

https://datalemur.com/questions/duplicate-job-listings

*/

-- My Solution

WITH job_count_cte AS (
  SELECT 
    company_id, 
    title, 
    description, 
    COUNT(job_id) AS job_count
  FROM job_listings
  GROUP BY company_id, title, description
)

SELECT COUNT(DISTINCT company_id) AS duplicate_companies
FROM job_count_cte
WHERE job_count > 1;

-- Other Solutions

SELECT COUNT(DISTINCT company_id) AS duplicate_companies
FROM (
  SELECT 
    company_id, 
    title, 
    description, 
    COUNT(job_id) AS job_count
  FROM job_listings
  GROUP BY company_id, title, description
) AS job_count_cte
WHERE job_count > 1;

-- 2nd attempt

with duplicate_jobs as (
  select company_id, title, description, count(job_id) as job_count
  from job_listings
  group by company_id, title, description
)

select count(distinct company_id) as duplicate_companies
from duplicate_jobs
where job_count > 1

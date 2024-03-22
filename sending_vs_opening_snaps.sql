-- Sending vs Opening Snaps

/*

https://datalemur.com/questions/time-spent-snaps

*/

-- My Solution
with total_time as (
  select age_bucket, sum(time_spent) as total_time
  from activities a join age_breakdown ab on a.user_id = ab.user_id
  where activity_type = 'open' or activity_type = 'send'
  group by age_bucket
),

open_time as (
  select age_bucket, sum(time_spent) as open_time
  from activities a join age_breakdown ab on a.user_id = ab.user_id
  where activity_type = 'open'
  group by age_bucket
),

send_time as (
  select age_bucket, sum(time_spent) as send_time
  from activities a join age_breakdown ab on a.user_id = ab.user_id
  where activity_type = 'send'
  group by age_bucket
)

select t.age_bucket,
       ROUND(open_time * 100.0/total_time, 2) as open_perc,
       ROUND(send_time * 100.0/total_time, 2) as send_perc
from total_time t join open_time ot using(age_bucket) join send_time using(age_bucket)


-- Provided Solutions
SELECT
  age.age_bucket, 
  ROUND(100.0 * 
    SUM(activities.time_spent) FILTER (WHERE activities.activity_type = 'send')/
      SUM(activities.time_spent),2) AS send_perc, 
  ROUND(100.0 * 
    SUM(activities.time_spent) FILTER (WHERE activities.activity_type = 'open')/
      SUM(activities.time_spent),2) AS open_perc
FROM activities
INNER JOIN age_breakdown AS age 
  ON activities.user_id = age.user_id 
WHERE activities.activity_type IN ('send', 'open') 
GROUP BY age.age_bucket;

-----------------

WITH snaps_statistics AS (
  SELECT 
    age.age_bucket, 
    SUM(CASE WHEN activities.activity_type = 'send' 
      THEN activities.time_spent ELSE 0 END) AS send_timespent, 
    SUM(CASE WHEN activities.activity_type = 'open' 
      THEN activities.time_spent ELSE 0 END) AS open_timespent, 
    SUM(activities.time_spent) AS total_timespent 
  FROM activities
 INNER JOIN age_breakdown AS age 
    ON activities.user_id = age.user_id 
  WHERE activities.activity_type IN ('send', 'open') 
  GROUP BY age.age_bucket) 

SELECT 
  age_bucket, 
  ROUND(100.0 * send_timespent / total_timespent, 2) AS send_perc, 
  ROUND(100.0 * open_timespent / total_timespent, 2) AS open_perc 
FROM snaps_statistics;

-- 2nd attempt

-- find total time by age group using SUM()/FILTER()/group by
with total_time_by_age as (
  select age_bucket,
         SUM(time_spent) FILTER(where activity_type = 'open') as total_open_time,
         SUM(time_spent) FILTER(where activity_type = 'send') as total_send_time
  from activities a join age_breakdown ab 
       on a.user_id = ab.user_id
  group by age_bucket
)

-- find percentage of time spent on each based on total time spent
select age_bucket,
       ROUND( total_open_time/(total_open_time + total_send_time) * 100, 2) as open_perc,
       ROUND( total_send_time/(total_open_time + total_send_time) * 100, 2) as send_perc
from total_time_by_age
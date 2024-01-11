-- App Click Through Rate

/*

https://datalemur.com/questions/click-through-rate

*/

-- My Solution

with click_rate as (
select app_id,
       SUM(CASE WHEN event_type = 'click' THEN 1 ELSE 0 end) as clicks,
       SUM(CASE WHEN event_type = 'impression' THEN 1 ELSE 0 end) as impressions
from events
where EXTRACT(YEAR from timestamp) = 2022
group by 1
)

select app_id, ROUND(100.0 * clicks/impressions, 2)
from click_rate

-- Solutions without CTEs

SELECT
  app_id,
  ROUND(100.0 *
    SUM(CASE WHEN event_type = 'click' THEN 1 ELSE 0 END) /
    SUM(CASE WHEN event_type = 'impression' THEN 1 ELSE 0 END), 2)  AS ctr_rate
FROM events
WHERE timestamp >= '2022-01-01' 
  AND timestamp < '2023-01-01'
GROUP BY app_id;


SELECT
  app_id,
  ROUND(100.0 *
    COUNT(CASE WHEN event_type = 'click' THEN 1 ELSE NULL END) /
    COUNT(CASE WHEN event_type = 'impression' THEN 1 ELSE NULL END), 2)  AS ctr_rate
FROM events
WHERE timestamp >= '2022-01-01' 
  AND timestamp < '2023-01-01'
GROUP BY app_id;

SELECT
  app_id,
  ROUND(100.0 *
    SUM(1) FILTER (WHERE event_type = 'click') /
    SUM(1) FILTER (WHERE event_type = 'impression'), 2) AS ctr_app
FROM events
WHERE timestamp >= '2022-01-01' 
  AND timestamp < '2023-01-01'
GROUP BY app_id;


-- 2nd attempt

with clicks_impressions as (
select 
  app_id,
  SUM(CASE WHEN event_type = 'click' then 1 else 0 end) as clicks,
  SUM(CASE WHEN event_type = 'impression' then 1 else 0 end) as impressions
from events
where extract(year from timestamp) = 2022
group by app_id
)

select
  app_id,
  ROUND(clicks * 1.0/impressions * 100.0, 2) as ctr 
from clicks_impressions
-- International Call Percentage

/*

https://datalemur.com/questions/international-call-percentage

*/

-- Solutions

SELECT 
  ROUND(
    100.0 * SUM(CASE
      WHEN caller.country_id <> receiver.country_id THEN 1 ELSE NULL END)
    /COUNT(*) ,1) AS international_call_pct
FROM phone_calls AS calls
LEFT JOIN phone_info AS caller
  ON calls.caller_id = caller.caller_id
LEFT JOIN phone_info AS receiver
  ON calls.receiver_id = receiver.caller_id;

---------------------------------------------
SELECT 
  ROUND(
    100.0 * COUNT(*) FILTER (
      WHERE caller.country_id <> receiver.country_id) 
  / COUNT(*), 1) AS international_calls_pct
FROM phone_calls AS calls
LEFT JOIN phone_info AS caller
  ON calls.caller_id = caller.caller_id
LEFT JOIN phone_info AS receiver
  ON calls.receiver_id = receiver.caller_id;

-----------------------------------------------
WITH international_calls AS (
SELECT 
  caller.caller_id, 
  caller.country_id,
  receiver.caller_id, 
  receiver.country_id
FROM phone_calls AS calls
LEFT JOIN phone_info AS caller
  ON calls.caller_id = caller.caller_id
LEFT JOIN phone_info AS receiver
  ON calls.receiver_id = receiver.caller_id
WHERE caller.country_id <> receiver.country_id
)

SELECT 
  ROUND(
    100.0 * COUNT(*)
  / (SELECT COUNT(*) FROM phone_calls),1) AS international_call_pct
FROM international_calls;

------------------------------------------------------------


with country_ids as (
select caller.country_id as caller_country,
       receiver.country_id as receiver_country
from phone_calls LEFT JOIN phone_info caller on phone_calls.caller_id = caller.caller_id
                 LEFT JOIN phone_info receiver on phone_calls.receiver_id = receiver.caller_id
)

select ROUND( SUM(CASE WHEN caller_country != receiver_country THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 1) as international_calls_pct
from country_ids
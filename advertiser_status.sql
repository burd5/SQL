-- https://datalemur.com/questions/updated-status

-- Advertiser Status

-- MY SOLUTION

-- user_id, current payment status, sorted by user_id
-- new, existing, churn, resurrect

-- if paid is null then CHURN
-- if status is churn and paid then resurrect
-- if status is not null and paid then existing
-- if status is null and paid then new

select COALESCE(a.user_id, dp.user_id) AS user_id,
       CASE WHEN paid IS NULL THEN 'CHURN'
            WHEN status = 'CHURN' AND paid IS NOT NULL THEN 'RESURRECT'
            WHEN status IS NOT NULL AND paid IS NOT NULL THEN 'EXISTING'
            WHEN status IS NULL AND paid IS NOT NULL THEN 'NEW' END as new_status
from advertiser a full outer join daily_pay dp on a.user_id = dp.user_id
order by user_id

-- PROVIDED SOLUTION

SELECT 
  COALESCE(advertiser.user_id, daily_pay.user_id) AS user_id,
  CASE 
    WHEN paid IS NULL THEN 'CHURN' 
    WHEN paid IS NOT NULL AND advertiser.status IN ('NEW','EXISTING','RESURRECT') THEN 'EXISTING'
    WHEN paid IS NOT NULL AND advertiser.status = 'CHURN' THEN 'RESURRECT'
    WHEN paid IS NOT NULL AND advertiser.status IS NULL THEN 'NEW'
  END AS new_status
FROM advertiser
FULL OUTER JOIN daily_pay
  ON advertiser.user_id = daily_pay.user_id
ORDER BY user_id;
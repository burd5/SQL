-- Repeated Payments

-- https://datalemur.com/questions/repeated-payments

-- FINAL SOLUTION

with minutes_diff as (
  SELECT *,
         EXTRACT(EPOCH FROM transaction_timestamp - LAG(transaction_timestamp) 
         OVER (partition by merchant_id, credit_card_id, amount order by transaction_timestamp)) / 60 as minute_difference
  FROM transactions
)

select count(*) as payment_count
from minutes_diff
where minute_difference <= 10 

--
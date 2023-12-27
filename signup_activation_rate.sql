-- Signup Activation Rate

/*

https://datalemur.com/questions/signup-confirmation-rate

*/

-- My Solution

SELECT 
  ROUND(SUM(CASE WHEN signup_action = 'Confirmed' THEN 1 ELSE 0 END) * 1.0/
  COUNT(e.email_id), 2) as confirm_rate
FROM emails e left join texts t on e.email_id = t.email_id;

-- Provided Solution

SELECT 
  ROUND(COUNT(texts.email_id)::DECIMAL
    /COUNT(DISTINCT emails.email_id),2) AS activation_rate
FROM emails
LEFT JOIN texts
  ON emails.email_id = texts.email_id
  AND texts.signup_action = 'Confirmed';


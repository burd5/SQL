-- Second Day Confirmation

/*

https://datalemur.com/questions/second-day-confirmation

*/

-- My Solution

SELECT user_id
FROM emails e join texts t using(email_id)
WHERE signup_date + interval '1' day = action_date and signup_action = 'Confirmed';

-- Listed Solution

SELECT DISTINCT user_id
FROM emails 
INNER JOIN texts
  ON emails.email_id = texts.email_id
WHERE texts.action_date = emails.signup_date + INTERVAL '1 day'
  AND texts.signup_action = 'Confirmed';



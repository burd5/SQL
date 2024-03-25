-- Tweets Rolling Averages

/*

https://datalemur.com/questions/rolling-average-tweets

*/

-- My Solution

SELECT user_id, tweet_date,
       ROUND(AVG(tweet_count) OVER(
       PARTITION BY user_id 
       ORDER BY tweet_date 
       ROWS BETWEEN 2 PRECEDING AND CURRENT ROW)
       , 2) as rolling_avg_3d
FROM tweets;

-- Provided Solutions

SELECT    
  user_id,    
  tweet_date,   
  ROUND(AVG(tweet_count) OVER (
    PARTITION BY user_id     
    ORDER BY tweet_date     
    ROWS BETWEEN 2 PRECEDING AND CURRENT ROW)
  ,2) AS rolling_avg_3d
FROM tweets;

-- 2nd attempt

-- rolling 3 day tweet average per user
-- user_id, tweet_date, tweet_count

-- SUM(tweets) between two_days_before and current_day, group by user

select
  user_id,
  tweet_date,
  ROUND(AVG(tweet_count) OVER(
    partition by user_id 
    order by tweet_date
    ROWS BETWEEN 2 PRECEDING AND CURRENT ROW), 2) as rolling_avg_3d
from tweets
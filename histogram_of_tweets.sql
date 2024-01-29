-- Histogram of Tweets

/*

Assume you're given a table Twitter tweet data, write a query to obtain a histogram of tweets posted per user in 2022. Output the tweet count per user as the bucket and the number of Twitter users who fall into that bucket.

In other words, group the users by the number of tweets they posted in 2022 and count the number of users in each group.

*/


-- My Solution

with tweet_counts as (
  SELECT COUNT(tweet_id) as num_of_tweets
  FROM tweets
  WHERE date_part('year', tweet_date) = 2022
  GROUP BY user_id)

SELECT num_of_tweets, COUNT(num_of_tweets) as users_num
FROM tweet_counts
GROUP BY 1

--- 2nd Attempt

with tweet_counts_by_user as (
  select
      user_id,
      count(user_id) as num_tweets
  from tweets
  where DATE_PART('year', tweet_date) = 2022
  group by user_id
)

select
    num_tweets as tweet_bucket,
    count(num_tweets) as users_num
from tweet_counts_by_user
group by num_tweets
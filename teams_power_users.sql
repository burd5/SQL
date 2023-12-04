-- Teams Power Users

/*

Write a query to identify the top 2 Power Users who sent the highest number of messages on Microsoft Teams in August 2022. Display the IDs of these 2 users along with the total number of messages they sent. Output the results in descending order based on the count of the messages.

Assumption:

No two users have sent the same number of messages in August 2022.

*/

-- My Solution

SELECT sender_id, COUNT(*) as message_count
FROM messages
WHERE DATE_PART('year', sent_date) = 2022 AND DATE_PART('month', sent_date) = 8
GROUP BY sender_id
ORDER BY 2 DESC
LIMIT 2;

-- Given Solution

SELECT 
  sender_id,
  COUNT(message_id) AS count_messages
FROM messages
WHERE EXTRACT(MONTH FROM sent_date) = '8'
  AND EXTRACT(YEAR FROM sent_date) = '2022'
GROUP BY sender_id
ORDER BY count_messages DESC
LIMIT 2; 



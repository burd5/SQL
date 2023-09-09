-- Rank Scores

/*

Write a solution to find the rank of the scores. The ranking should be calculated according to the following rules:

The scores should be ranked from the highest to the lowest.
If there is a tie between two scores, both should have the same ranking.
After a tie, the next ranking number should be the next consecutive integer value. In other words, there should be no holes between ranks.
Return the result table ordered by score in descending order.

*/

-- Solution

SELECT score, DENSE_RANK() OVER (ORDER BY score DESC) as 'rank'
FROM scores

-- Other Solution

SELECT S1.Score, (
    SELECT COUNT(DISTINCT Score) FROM Scores WHERE Score >= S1.Score) AS Rank
FROM Scores S1
ORDER BY S1.Score DESC
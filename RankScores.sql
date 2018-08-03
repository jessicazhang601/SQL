/*

Write a SQL query to rank scores. If there is a tie between two scores, both should have the same ranking. Note that after a tie, the next ranking number should be the next consecutive integer value. In other words, there should be no "holes" between ranks.

+----+-------+
| Id | Score |
+----+-------+
| 1  | 3.50  |
| 2  | 3.65  |
| 3  | 4.00  |
| 4  | 3.85  |
| 5  | 4.00  |
| 6  | 3.65  |
+----+-------+
For example, given the above Scores table, your query should generate the following report (order by highest score):

+-------+------+
| Score | Rank |
+-------+------+
| 4.00  | 1    |
| 4.00  | 1    |
| 3.85  | 2    |
| 3.65  | 3    |
| 3.65  | 3    |
| 3.50  | 4    |
+-------+------+

*/

# Write your MySQL query statement below
select Score as "Score", (SELECT count(distinct Score) FROM Scores WHERE Score >= s.Score) as "Rank"
from Scores s
order by Score desc

# faster solution
SELECT
  Score,
  (SELECT count(*) FROM (SELECT distinct Score s FROM Scores) tmp WHERE s >= Score) Rank
FROM Scores
ORDER BY Score desc

# solution by menarguez: "get the rows the distinct rows that are <= that each score, count them and wrap them in an external SELECT for formatting"
SELECT Scores.Score, Q3.Rank
FROM(
    SELECT Q1.Score as Score, COUNT(Q1.Score) as Rank
    FROM 
        (SELECT DISTINCT Score from Scores) as Q1,
        (SELECT DISTINCT Score from Scores) as Q2
    WHERE Q1.Score <= Q2.Score
    GROUP BY Q1.Score
    ) as Q3, Scores
WHERE Q3.Score = Scores.Score
ORDER BY Scores.Score DESC
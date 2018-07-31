/*
Given a Weather table, write a SQL query to find all dates' Ids with higher temperature compared to its previous (yesterday's) dates.

+---------+------------------+------------------+
| Id(INT) | RecordDate(DATE) | Temperature(INT) |
+---------+------------------+------------------+
|       1 |       2015-01-01 |               10 |
|       2 |       2015-01-02 |               25 |
|       3 |       2015-01-03 |               20 |
|       4 |       2015-01-04 |               30 |
+---------+------------------+------------------+
For example, return the following Ids for the above Weather table:

+----+
| Id |
+----+
|  2 |
|  4 |
+----+
*/

#solution 1
select w2.Id as "Id"
from Weather w1, Weather w2
where TO_DAYS(w2.RecordDate) - TO_DAYS(w1.RecordDate) = 1 and w2.Temperature > w1.Temperature

#solution 2
SELECT a.Id FROM Weather AS a, Weather AS b
WHERE DATEDIFF(a.RecordDate, b.RecordDate)=1 AND a.Temperature > b.Temperature
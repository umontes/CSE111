-- Find the number of customers that 
-- had at most two orders in August 1996(o_orderdate).

SELECT COUNT(*)
FROM (
    SELECT o_custkey
    FROM orders
    WHERE o_orderdate like '1996-08%'
    GROUP BY o_custkey
    HAVING COUNT(*) <= 2
    ) AtMost2;
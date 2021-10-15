-- Find the minimum account balance of the suppliers from countries with less than 3 suppliers. 
-- Print the country and the minimum account balance.

SELECT 
    (SELECT n_name
    FROM nation
    WHERE s_nationkey = n_nationkey) AS country, min(s_acctbal)
    FROM supplier
    GROUP BY s_nationkey
    HAVING count(*) < 3
-- Find how many suppliers from CANADA supply 
-- at least 4 different parts.

SELECT COUNT(*)
FROM (
    SELECT s_suppkey
    FROM part, partsupp, supplier, nation
    WHERE p_partkey = ps_partkey
        AND ps_suppkey = s_suppkey
        AND s_nationkey = n_nationkey
        AND n_name = 'CANADA'
    GROUP BY s_suppkey
    HAVING COUNT(DISTINCT p_partkey) >= 4
    ) Atleast4;
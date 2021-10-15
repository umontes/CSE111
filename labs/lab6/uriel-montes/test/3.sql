-- Find how many parts are supplied by 
-- more than one supplier from CANADA.

SELECT COUNT(NumParts)
FROM (
    SELECT COUNT(DISTINCT p_partkey) AS NumParts
    FROM part, partsupp, supplier, nation
    WHERE p_partkey = ps_partkey
        AND ps_suppkey = s_suppkey
        AND s_nationkey = n_nationkey
        AND n_name = 'CANADA'
    GROUP BY p_partkey
    HAVING COUNT(s_suppkey) > 1
    ) MoreThan1;
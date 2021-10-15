-- Find the parts (p_name) ordered by customers 
-- from AMERICA that are supplied by exactly 4 
-- distinct suppliers from ASIA.

SELECT DISTINCT p_name
FROM lineitem, part
WHERE l_orderkey IN (
                    SELECT o_orderkey
                    FROM nation, customer, orders
                    WHERE c_nationkey = n_nationkey
                        AND c_custkey = o_custkey
                        AND n_regionkey = 1
                    )
    AND p_partkey IN (
                    SELECT l_partkey
                    FROM nation, supplier, lineitem
                    WHERE n_nationkey = s_nationkey
                        AND s_suppkey = l_suppkey
                        AND n_regionkey = 2
                    GROUP BY l_partkey
                    HAVING COUNT(DISTINCT l_suppkey) = 4
                    )
    AND p_partkey = l_partkey
GROUP BY l_orderkey
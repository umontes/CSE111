-- Find how many distinct customers have at 
-- least one order supplied exclusively by suppliers from ASIA.

SELECT COUNT(DISTINCT c_custkey)
FROM customer, orders
WHERE c_custkey = o_custkey
    AND o_orderkey NOT IN (
                        SELECT DISTINCT o_orderkey
                        FROM orders, nation, supplier, lineitem
                        WHERE s_suppkey = l_suppkey
                            AND l_orderkey = o_orderkey
                            AND s_nationkey = n_nationkey
                            AND n_regionkey NOT IN (2)
    )
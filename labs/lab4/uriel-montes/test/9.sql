-- How many different order clerks did the suppliers in CANADA work with?

SELECT COUNT(DISTINCT o_clerk)
FROM nation, supplier, orders, lineitem
WHERE n_nationkey = s_nationkey
    AND l_orderkey = o_orderkey
    AND l_suppkey = s_suppkey
    AND n_name = 'CANADA'
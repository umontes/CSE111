-- Find the total price of orders made by customers from EUROPE in 1996.

SELECT SUM(o_totalprice)
FROM orders, region, nation, customer
WHERE r_regionkey = n_regionkey
    AND c_nationkey = n_nationkey
    AND c_custkey = o_custkey
    AND r_name = 'EUROPE'
    AND o_orderdate LIKE '1996-%'
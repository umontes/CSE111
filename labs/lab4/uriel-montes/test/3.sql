-- How many orders are made by customers in each country in ASIA?

SELECT n_name, count(o_orderkey)
FROM nation, orders, customer, region
WHERE c_nationkey = n_nationkey
    AND c_custkey = o_custkey
    AND r_regionkey = n_regionkey
    AND r_name = 'ASIA'
GROUP BY n_name
-- How many orders do customers in every country in EUROPE have in each status?
-- Print the country name, the order status, and the count.

SELECT n_name, o_orderstatus, count(o_orderkey)
FROM nation, orders, customer
WHERE n_nationkey = c_nationkey
    AND c_custkey = o_custkey
    AND n_regionkey = 3
GROUP BY n_name, o_orderstatus 
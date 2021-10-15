-- What are the countries of customers who ordered items between March 10-12, 1995?

SELECT DISTINCT n_name
FROM customer, nation, orders
WHERE c_custkey = o_custkey
    AND n_nationkey = c_nationkey
    AND o_orderdate >= '1995-03-10'
    AND o_orderdate <= '1995-03-12'
ORDER BY n_name;
-- Find the total price paid on orders by every customer from RUSSIA in 1996.  Print the customer name and the total price.

SELECT c_name, sum(o_totalprice)
FROM customer, orders, nation
WHERE c_custkey = o_custkey
    AND c_nationkey = n_nationkey
    AND o_orderdate LIKE '1996-%'
    AND n_name = 'RUSSIA'
GROUP BY c_name;
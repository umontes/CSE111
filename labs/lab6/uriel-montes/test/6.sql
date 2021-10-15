-- Find the supplier-customer pair(s) with the expensive
-- (o_totalprice) completed (F in o_orderstatus) order(s)

SELECT s_name, c_name
FROM supplier, customer, orders, lineitem
WHERE c_custkey = o_custkey
    AND s_suppkey = l_suppkey
    AND l_orderkey = o_orderkey
    AND o_orderstatus = 'F'
    AND o_totalprice = (
                        SELECT MAX(o_totalprice)
                        FROM orders
                        WHERE o_orderstatus = 'F'
                        )
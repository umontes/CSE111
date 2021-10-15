-- Find how many 1-URGENT priority orders have been posted by customers from France between 1994 and 1996, combined.

SELECT COUNT(o_orderpriority)
FROM orders, customer, nation
WHERE o_orderpriority = '1-URGENT'
    AND o_custkey = c_custkey
    AND c_nationkey = n_nationkey
    AND n_name = 'FRANCE'
    AND o_orderdate >= '1994-01-01'
    AND o_orderdate <= '1996-12-31';
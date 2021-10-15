-- How many distinct orders are between customers and suppliers 
-- with negative account balance?

SELECT COUNT(DISTINCT o_orderkey)
FROM lineitem
INNER JOIN orders ON lineitem.l_orderkey = orders.o_orderkey
INNER JOIN customer ON orders.o_custkey = customer.c_custkey
INNER JOIN supplier ON lineitem.l_suppkey = supplier.s_suppkey
WHERE s_acctbal < 0
    AND c_acctbal < 0
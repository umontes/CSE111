-- List the total number of orders between any two regions, i.e., the suppliers are from one region and the
-- customers are from another region.
-- Correct Answer

SELECT customer_region, supplier_region, COUNT(*)
FROM 
    (SELECT *, r_name AS customer_region
    FROM orders
        INNER JOIN customer ON orders.o_custkey = customer.c_custkey
        INNER JOIN nation ON customer.c_nationkey = nation.n_nationkey
        INNER JOIN region ON nation.n_regionkey = region.r_regionkey),
    (SELECT *, r_name AS supplier_region
    FROM lineitem
        INNER JOIN supplier ON lineitem.l_suppkey = supplier.s_suppkey
        INNER JOIN nation ON supplier.s_nationkey = nation.n_nationkey
        INNER JOIN region ON nation.n_regionkey = region.r_regionkey)
WHERE l_orderkey = o_orderkey
GROUP BY customer_region, supplier_region
-- Find  the  number  of  distinct  orders  completed  in  1994  by
-- the  suppliers  in  every  country. An  orderstatus of F stands for 
-- complete.  Print only those countries for which the number of
-- orders is larger than 300

SELECT n_name, COUNT(DISTINCT o_orderkey)
FROM supplier, nation, orders, lineitem
WHERE s_nationkey = n_nationkey
    AND l_orderkey = o_orderkey
    AND l_suppkey = s_suppkey
    AND o_orderstatus = 'F'
    AND o_orderdate LIKE '1994%'
GROUP BY n_name
HAVING COUNT(DISTINCT o_orderkey) > 300
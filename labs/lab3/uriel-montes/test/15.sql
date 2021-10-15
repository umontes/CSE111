-- Find  the  total  number  of1-URGENTpriority  orders  supplied  by  suppliers  in  each  region  each  year(fromoorderdate).  Print the year, region name, and the count sorted by the year then the region inincreasing order.  Check thesubstrfunction inSQLite.

SELECT substr(o_orderdate, 1, 4) AS orderdate, r_name, COUNT(o_orderpriority)
FROM orders, region, nation, supplier, lineitem
WHERE l_orderkey = o_orderkey
    AND s_suppkey = l_suppkey
    AND s_nationkey = n_nationkey
    AND r_regionkey = n_regionkey
    AND o_orderpriority = '1-URGENT'
GROUP BY r_name, orderdate;
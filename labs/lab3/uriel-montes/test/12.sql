-- Find the number of orders having status F for each customer region and display them in descending order.  Print the region name and the number of status Forders.

SELECT DISTINCT r_name, COUNT(o_orderstatus)
FROM region, orders, customer, nation
WHERE r_regionkey = n_regionkey
    AND n_nationkey = c_nationkey
    AND c_custkey = o_custkey
    AND o_orderstatus = 'F'
    AND r_name = 'AFRICA';

SELECT DISTINCT r_name, COUNT(o_orderstatus)
FROM region, orders, customer, nation
WHERE r_regionkey = n_regionkey
    AND n_nationkey = c_nationkey
    AND c_custkey = o_custkey
    AND o_orderstatus = 'F'
    AND r_name = 'AMERICA';

SELECT DISTINCT r_name, COUNT(o_orderstatus)
FROM region, orders, customer, nation
WHERE r_regionkey = n_regionkey
    AND n_nationkey = c_nationkey
    AND c_custkey = o_custkey
    AND o_orderstatus = 'F'
    AND r_name = 'ASIA';

SELECT DISTINCT r_name, COUNT(o_orderstatus)
FROM region, orders, customer, nation
WHERE r_regionkey = n_regionkey
    AND n_nationkey = c_nationkey
    AND c_custkey = o_custkey
    AND o_orderstatus = 'F'
    AND r_name = 'EUROPE';

SELECT DISTINCT r_name, COUNT(o_orderstatus)
FROM region, orders, customer, nation
WHERE r_regionkey = n_regionkey
    AND n_nationkey = c_nationkey
    AND c_custkey = o_custkey
    AND o_orderstatus = 'F'
    AND r_name = 'MIDDLE EAST';
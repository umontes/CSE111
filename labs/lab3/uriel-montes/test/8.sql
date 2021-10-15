-- Find the name of the suppliers from ASIA who have less than $1000 on account balance.

SELECT s_name
FROM supplier, region, nation
WHERE r_regionkey = n_regionkey
    AND n_nationkey = s_nationkey
    AND r_name = 'ASIA'
    AND s_acctbal < '1000'
ORDER BY s_name;
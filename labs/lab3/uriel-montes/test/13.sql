-- Find the average account balance of all the customers from AFRICA in the MACHINERY market segment.

SELECT AVG(c_acctbal)
FROM customer, nation, region
WHERE c_nationkey = n_nationkey
    AND n_regionkey = r_regionkey
    AND r_name = 'AFRICA'
    AND c_mktsegment = 'MACHINERY';
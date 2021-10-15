-- Find  how  many  suppliers  have  less  than  
-- 30  distinct  orders  from  customers  
-- in GERMANY and FRANCE together.

SELECT COUNT(DISTINCT l_suppkey)
FROM (
    SELECT l_suppkey, COUNT(DISTINCT o_orderkey) AS LessThan30
    FROM lineitem, orders, nation, customer
    WHERE n_nationkey = c_nationkey
        AND c_custkey = o_custkey
        AND o_orderkey = l_orderkey
        AND (n_name = 'GERMANY' OR n_name = 'FRANCE')
    GROUP BY l_suppkey
    ) AS result
WHERE result.LessThan30 < 30;
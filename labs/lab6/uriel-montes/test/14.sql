-- Compute, for every country, the value of economic 
-- exchange, i.e., the difference between the number of 
-- items from suppliers in that country sold to 
-- customers in other countries and the number of 
-- items bought by local customers from foreign suppliers 
-- in 1996(l_shipdate). Sort the results in decreasing order 
-- of the economic exchange.

SELECT custNum, (Num2 - Num1)
FROM (
    SELECT  n1.n_name AS custNum, 
            n2.n_name AS suppNum, 
            COUNT(o_orderkey) AS Num1
    FROM nation n1, customer, orders, lineitem, supplier, nation n2
    WHERE n1.n_nationkey = c_nationkey
        AND c_custkey = o_custkey
        AND o_orderkey = l_orderkey
        AND l_suppkey = s_suppkey
        AND s_nationkey = n2.n_nationkey
        AND n1.n_name <> n2.n_name
        AND l_shipdate LIKE '1996%'
    GROUP BY n1.n_name
    ),
    (
    SELECT  n1.n_name AS custNum1,
            n2.n_name AS suppNum2, 
            COUNT(o_orderkey) AS Num2
    FROM nation n1, customer, orders, lineitem, supplier, nation n2
    WHERE n1.n_nationkey = c_nationkey
        AND c_custkey = o_custkey
        AND o_orderkey = l_orderkey
        AND l_suppkey = s_suppkey
        AND s_nationkey = n2.n_nationkey
        AND n1.n_name <> n2.n_name
        AND l_shipdate like '1996%'
    GROUP BY n2.n_name
    )
WHERE custNum = suppNum2
ORDER BY (Num2 - Num1) DESC;
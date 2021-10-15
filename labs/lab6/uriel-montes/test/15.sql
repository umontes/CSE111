-- Compute the change in the economic exchange for 
-- every country between 1994 and 1996. There should be 
-- two columns in the output for every country: 1995 and 1996.  
-- Hint: use CASE to select the values in the result.

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
        AND l_shipdate BETWEEN '1994%' AND '1996%'
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
        AND l_shipdate BETWEEN '1994%' AND '1996%'
    GROUP BY n2.n_name
    )
WHERE custNum = suppNum2
ORDER BY (Num2 - Num1) DESC;
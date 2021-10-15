-- Find the nation(s) with the most developed industry, 
-- i.e., selling items totaling the largest amount 
-- of money (l_extendedprice) in 1996 (l_shipdate).

SELECT n_name
FROM lineitem, (
                SELECT n_name, MAX(NationLarge)
                FROM (
                    SELECT n_name, SUM(l_extendedprice) AS NationLarge
                    FROM nation, supplier, lineitem
                    WHERE n_nationkey = s_nationkey
                        AND s_suppkey = l_suppkey
                    GROUP BY n_name
                    ) AS result
                ) MostDeveloped
WHERE l_shipdate like '1996%'
GROUP BY n_name;
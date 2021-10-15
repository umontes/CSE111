-- Find the nation(s) having customers that 
-- spend the largest amount of money (o_totalprice).

SELECT n_name
FROM (
    SELECT n_name, MAX(NationTotal)
    FROM (
        SELECT n_name, SUM(o_totalprice) AS NationTotal
        FROM nation, customer, orders
        WHERE n_nationkey = c_nationkey
            AND c_custkey = o_custkey
        GROUP BY n_name
        ) largestMoney
    ) MaxMoney;
-- Find the nation(s) with the largest number of customers.

SELECT n_name
FROM nation, customer
WHERE c_nationkey = n_nationkey
GROUP BY n_name
HAVING COUNT(*) = (
                SELECT MAX(NationCust)
                FROM (
                    SELECT COUNT(c_custkey) AS NationCust
                    FROM nation, customer
                    WHERE c_nationkey = n_nationkey
                    GROUP BY n_name
                    ) largestCust
                );
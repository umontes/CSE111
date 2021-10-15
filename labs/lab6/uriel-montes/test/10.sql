-- Find the region where customers spend the 
-- largest amount of money (l_extendedprice) 
-- buying items from suppliers in the same region.

SELECT r_name
FROM (
    SELECT r_name, MAX(spent)
    FROM (
        SELECT r_name, SUM(l_extendedprice) AS spent
        FROM region, lineitem, nation, customer, supplier
        WHERE c_nationkey = n_nationkey
            AND s_nationkey = n_nationkey
            AND n_regionkey = r_regionkey
            AND l_suppkey = s_suppkey
        GROUP BY r_name
        ) RegionSpent
    ) MaxSpent;
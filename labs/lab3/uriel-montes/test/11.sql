-- Find the customers that received at least a 5% discount for at least 70 items. Print the custkey and the number of discounted items.

SELECT o_custkey, COUNT(l_discount)
FROM orders, lineitem
WHERE o_orderkey = l_orderkey
    AND l_discount >= 0.05
GROUP BY o_custkey
HAVING COUNT(l_quantity) >= 70;
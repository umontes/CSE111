-- Find how many distinct suppliers 
-- supply the least expensive part (p_retailprice).

SELECT COUNT(DISTINCT s_suppkey)
FROM supplier, part, partsupp
WHERE s_suppkey = ps_suppkey
    AND ps_partkey = p_partkey
    AND p_retailprice = (
                        SELECT MIN(p_retailprice)
                        FROM part
                        );
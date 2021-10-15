-- How  many  parts  with  size  below 30 does  every  supplier  from CHINA offer?
-- Print  the  name  of  the supplier and the number of parts.

SELECT s_name, COUNT (DISTINCT p_partkey)
FROM supplier, part, nation, partsupp
WHERE s_nationkey = n_nationkey AND
      p_partkey = ps_partkey AND 
      ps_suppkey = s_suppkey AND
      n_name = 'CHINA' AND
      p_size < 30 
GROUP BY s_name;
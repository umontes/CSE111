
-- Create a trigger t5 that removes all the tuples 
-- from partsupp and lineitem corresponding to a 
-- part being deleted. Delete all the parts supplied 
-- by suppliers from FRANCE or GERMANY. Write a query 
-- that returns the number of parts supplied by every 
-- supplier in EUROPE grouped by their country in 
-- increasing order. Put all the SQL statements 
-- in filetest/5.sql.  (3 points)



DROP TRIGGER IF EXISTS t5;

-- t5
CREATE TRIGGER t5 AFTER DELETE ON part
BEGIN
	DELETE
    FROM lineitem 
    WHERE l_partkey = OLD.p_partkey;

	DELETE
    FROM partsupp 
    WHERE ps_partkey = OLD.p_partkey;
END;

-- delete parts supplied by suppliers from FRANCE/GERMANY
DELETE 
FROM part
WHERE p_partkey IN (
                    SELECT ps_partkey
                    FROM partsupp, supplier, nation
                    WHERE ps_suppkey = s_suppkey
                        AND s_nationkey = n_nationkey
                        AND n_name = 'FRANCE'
                        AND n_name = 'GERMANY'
                    );

-- return # of parts from suppliers in EUROPE
SELECT n_name, COUNT(p_partkey)
FROM part, supplier, partsupp, nation, region
WHERE p_partkey = ps_partkey
    AND ps_suppkey = s_suppkey
    AND s_nationkey = n_nationkey
    AND n_regionkey = r_regionkey
    AND r_name = 'EUROPE'
GROUP BY n_name;

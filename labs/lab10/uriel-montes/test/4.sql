
-- Create triggers that update the attribute o_orderpriority 
-- to HIGH every time a new lineitem tuple is added to or
-- deleted from that order. Delete all the line items 
-- corresponding to orders from November 1996.  Write 
-- a query that returns the number of HIGH priority 
-- orders in the fourth trimester of 1996. Put all the 
-- SQL statements in filetest/4.sql.  (3 points)



DROP TRIGGER IF EXISTS t4_insert;
DROP TRIGGER IF EXISTS t4_delete;

-- t4 insert
CREATE TRIGGER t4_insert AFTER INSERT ON lineitem
BEGIN
	UPDATE orders
	SET o_orderpriority = 'HIGH'
	WHERE o_orderkey = NEW.l_orderkey;
END;

-- t4 delete
CREATE TRIGGER t4_delete AFTER DELETE ON lineitem
BEGIN
	UPDATE orders
	SET o_orderpriority = 'HIGH'
	WHERE o_orderkey = OLD.l_orderkey;
END;

-- delete lineitems corresponding to orders from nov 1996
DELETE 
FROM lineitem
WHERE l_orderkey IN (
                    SELECT o_orderkey
                    FROM orders
                    WHERE o_orderdate LIKE '1996-11-__'
                    );

-- return # of HIGH priority orders in 4th trimester
SELECT COUNT(o_orderkey)
FROM orders
WHERE o_orderpriority LIKE 'HIGH'
    AND o_orderdate LIKE '1996-11%'
    
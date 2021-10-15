
-- Create a trigger t1 that for every new order entry automatically 
-- fills the o_orderdate attribute with the date 2020-12-01. Insert
-- into orders all the orders from November 1995, paying close attentionon 
-- how the o_orderkey attribute is set. Write a query that returns 
-- the number of orders from 2020. Put all the three SQL statements in 
-- file test/1.sql.  (3 points)



DROP TRIGGER IF EXISTS t1;

-- t1
CREATE TRIGGER t1 BEFORE INSERT ON orders
BEGIN
    UPDATE orders
    SET o_orderdate = '2020-12-01'
    WHERE o_orderkey = NEW.o_orderkey;
END;

-- deletes the unneeded row
DELETE FROM orders
WHERE o_orderkey = 'o_orderkey';

-- insert all orders from nov 1995
INSERT INTO orders(o_orderkey, o_custkey, o_orderstatus, o_totalprice, o_orderdate, o_orderpriority, o_clerk, o_shippriority, o_comment)
VALUES ('o_orderkey', 'o_custkey', 'o_orderstatus', 'o_totalprice', '1995-11%', 'o_orderpriority', 'o_clerk', 'o_shippriority', 'o_comment');

-- return # of orders from 2020
SELECT COUNT(o_orderkey)
FROM orders
WHERE o_orderdate LIKE '2020%';
